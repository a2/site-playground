import Foundation
import Plot

#if canImport(WebKit)
import WebKit
#endif

public enum SassError: Error {
    case scriptExecutionFailure
    case typeCoercionFailure
}

public final class Sass {
    public enum OutputStyle: String {
        case expanded
        case compressed
    }

    public struct Options {
        public var indentedSyntax: Bool
        public var outputStyle: OutputStyle
        public var indentation: Indentation.Kind

        public init(indentedSyntax: Bool = false, outputStyle: Sass.OutputStyle = .expanded, indentation: Indentation.Kind = .spaces(2)) {
            self.indentedSyntax = indentedSyntax
            self.outputStyle = outputStyle
            self.indentation = indentation
        }

        func toDictionary() -> [String: Any] {
            let (indentType, indentWidth): (String, Int) = {
                switch indentation {
                case .spaces(let width):
                    return ("spaces", width)
                case .tabs(let width):
                    return ("tabs", width)
                }
            }()

            return [
                "outputStyle": outputStyle.rawValue,
                "indentType": indentType,
                "indentWidth": indentWidth,
            ]
        }
    }

    let scriptSource: String
    #if canImport(WebKit)
    let webView: WKWebView
    #endif

    public init(scriptSource: String) {
        self.scriptSource = scriptSource
        #if canImport(WebKit)
        self.webView = WKWebView()
        #endif
    }

    #if canImport(WebKit)
    private static func parseValue(_ value: Any) -> Result<String, Error> {
        guard let object = value as? [AnyHashable: Any], let css = object["css"] as? String else {
            return .failure(SassError.typeCoercionFailure)
        }

        return .success(css + "\n")
    }
    #endif

    public func compile(styles: String, options: Options = .init(), completionHandler: @escaping (Result<String, Error>) -> Void) {
        #if canImport(WebKit)
        let optionsDictionary = options.toDictionary().merging(["data": styles], uniquingKeysWith: { _, new in new })
        let wrapperScript = "return exports = {}, require = () => {}, process = { env: {}, cwd: () => \"\" }, Buffer = { from: x => x }, eval(script), exports.renderSync(options)"
        webView.callAsyncJavaScript(wrapperScript, arguments: ["script": scriptSource, "options": optionsDictionary], in: nil, in: .defaultClient) { result in
            completionHandler(result.flatMap(Self.parseValue))
        }
        #else
        do {
            let stdin = Pipe(), stdout = Pipe()

            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/local/bin/sass")
            process.standardInput = stdin
            process.standardOutput = stdout
            process.arguments = {
                var arguments = ["--stdin"]

                if options.indentedSyntax {
                    arguments.append("--indented")
                }

                switch options.outputStyle {
                case .expanded:
                    arguments.append("--style=expanded")
                case .compressed:
                    arguments.append("--style=compressed")
                }

                return arguments
            }()

            try process.run()

            let stdinHandle = stdin.fileHandleForWriting
            try stdinHandle.write(contentsOf: Data(styles.utf8))
            try stdinHandle.close()

            process.waitUntilExit()

            let stdoutHandle = stdout.fileHandleForReading
            let stdoutData: Data = {
                var data = Data()
                while case let availableData = stdoutHandle.availableData, !availableData.isEmpty {
                    data.append(availableData)
                }

                return data
            }()

            completionHandler(.success(String(decoding: stdoutData, as: UTF8.self)))
        } catch {
            completionHandler(.failure(error))
        }
        #endif
    }

    public func compileSync(styles: String, options: Options = .init()) throws -> String {
        var finished = false
        var result: Result<String, Error>?

        func evaluate() {
            compile(styles: styles, options: options) { innerResult in
                result = innerResult
                finished = true
            }

            RunLoop.current.run(until: { finished })
        }

        if Thread.isMainThread {
            evaluate()
        } else {
            DispatchQueue.main.sync(execute: evaluate)
        }

        return try result!.get()
    }
}

extension RunLoop {
    func run(mode: Mode = .default, until condition: () -> Bool) {
        while !condition() {
            _ = run(mode: mode, before: .distantPast)
        }
    }
}
