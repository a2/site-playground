import Foundation
import Plot
import WebKit

public enum SassError: Error {
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
    let webView: WKWebView

    public init(scriptSource: String) {
        self.scriptSource = scriptSource
        self.webView = WKWebView()
    }

    private static func parseValue(_ value: Any) -> Result<String, Error> {
        guard let object = value as? [AnyHashable: Any], let css = object["css"] as? String else {
            return .failure(SassError.typeCoercionFailure)
        }

        return .success(css)
    }

    public func compile(styles: String, options: Options = .init(), completionHandler: @escaping (Result<String, Error>) -> Void) {
        let optionsDictionary = options.toDictionary().merging(["data": styles], uniquingKeysWith: { _, new in new })
        let wrapperScript = "return exports = {}, require = () => {}, process = { env: {}, cwd: () => \"\" }, Buffer = { from: x => x }, eval(script), exports.renderSync(options)"
        webView.callAsyncJavaScript(wrapperScript, arguments: ["script": scriptSource, "options": optionsDictionary], in: nil, in: .defaultClient) { result in
            completionHandler(result.flatMap(Self.parseValue))
        }
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
            run(mode: mode, before: .distantPast)
        }
    }
}
