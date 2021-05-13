import Foundation
import WebKit

public enum SassError: Error {
    case typeCoercionFailure
}

public final class Sass {
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

    public func compile(styles: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let wrapperScript = "return exports = {}, require = () => {}, process = { env: {}, cwd: () => \"\" }, Buffer = { from: x => x }, eval(script), exports.renderSync(options)"
        webView.callAsyncJavaScript(wrapperScript, arguments: ["script": scriptSource, "options": ["data": styles]], in: nil, in: .defaultClient) { result in
            completionHandler(result.flatMap(Self.parseValue))
        }
    }

    public func compileSync(styles: String) throws -> String {
        var finished = false
        var result: Result<String, Error>?

        func evaluate() {
            compile(styles: styles) { innerResult in
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
