import Foundation
import JavaScriptCore

typealias JSFunction = @convention(block) () -> Any?

extension JSValue {
    subscript(key: Any?) -> JSValue? {
        get { objectForKeyedSubscript(key) }
        set { setObject(newValue, forKeyedSubscript: key) }
    }

    func define(name: String, value: JSValue) {
        defineProperty(name, descriptor: [JSPropertyDescriptorValueKey: value])
    }

    func define(name: String, function: @convention(block) @escaping () -> Any?) {
        defineProperty(name, descriptor: [JSPropertyDescriptorValueKey: function])
    }
}

public class Sass {
    let context: JSContext

    public init(sourceURL: URL) {
        self.context = JSContext()
        self.configureContext(sourceURL: sourceURL)
    }

    func configureContext(sourceURL: URL) {
        let global = context.globalObject!
        global["global"] = global
        global.define(name: "require", function: { JSValue(newObjectIn: JSContext.current()) })

        let exports = JSValue(newObjectIn: context)!
        global.define(name: "exports", value: exports)

        let process = JSValue(newObjectIn: context)!
        process.define(name: "cwd", function: { "/" })
        process.define(name: "env", value: JSValue(newObjectIn: context))
        global.define(name: "process", value: process)

        let buffer = JSValue(newObjectIn: context)!
        buffer.define(name: "from", function: { JSContext.currentArguments()![0] as! JSValue })
        global.define(name: "Buffer", value: buffer)

        global.define(name: "print", function: {
            print("print:", JSContext.currentArguments()![0] as! JSValue)
            return JSValue(undefinedIn: JSContext.current())
        })

        let script = try! String(contentsOf: sourceURL)
        context.evaluateScript(script)
    }

    public func compile(string: String) -> String {
        let renderResult = context.globalObject["exports"]!["renderSync"]!.call(withArguments: [["data": string]])
        return renderResult!["css"]!.toString()
    }
}
