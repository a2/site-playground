import Foundation

fileprivate let JavaScriptCoreBundle = Bundle(identifier: "com.apple.JavaScriptCore")!

final class JSContext: NSObject {
    fileprivate let rawContext: NSObject

    fileprivate static let JSContextClass = JavaScriptCoreBundle.classNamed("JSContext") as! NSObject.Type

    override init() {
        self.rawContext = Self.JSContextClass.init()
    }

    class func current() -> JSContext! {
        let rawContext = unsafeDowncast(Self.JSContextClass, to: NSObject.self)
            .perform(Selector(("currentContext")))?
            .takeUnretainedValue()
        return JSContext(rawContext as! NSObject)
    }

    class func currentArguments() -> [Any]! {
        let rawValues = unsafeDowncast(Self.JSContextClass, to: NSObject.self)
            .perform(Selector(("currentArguments")))?
            .takeUnretainedValue() as? [NSObject]
        return rawValues?.map(JSValue.init)
    }

    fileprivate init(_ rawContext: NSObject) {
        self.rawContext = rawContext
    }

    var globalObject: JSValue! {
        let rawValue = rawContext.perform(Selector(("globalObject")))!
            .takeUnretainedValue() as! NSObject
        return JSValue(rawValue)
    }

    @discardableResult
    func evaluateScript(_ script: String!) -> JSValue! {
        let rawValue = rawContext.perform(Selector(("evaluateScript:")), with: script)?
            .takeUnretainedValue() as! NSObject
        return JSValue(rawValue)
    }

    override var description: String { "JSContext()" }
}

final class JSValue: NSObject {
    fileprivate let rawValue: NSObject

    fileprivate static let JSValueClass = JavaScriptCoreBundle.classNamed("JSValue") as! NSObject.Type

    fileprivate init(_ rawValue: NSObject) {
        self.rawValue = rawValue
    }

    init!(newObjectIn context: JSContext) {
        self.rawValue = unsafeDowncast(Self.JSValueClass, to: NSObject.self)
            .perform(Selector(("valueWithNewObjectInContext:")), with: context.rawContext)?
            .takeUnretainedValue() as! NSObject
    }

    init!(undefinedIn context: JSContext) {
        self.rawValue = unsafeDowncast(Self.JSValueClass, to: NSObject.self)
            .perform(Selector(("valueWithUndefinedInContext:")), with: context.rawContext)?
            .takeUnretainedValue() as! NSObject
    }

    func call(withArguments arguments: [Any]!) -> JSValue! {
        let rawArguments: [Any] = arguments!.map { argument in
            if let value = argument as? JSValue {
                return value.rawValue
            } else {
                return argument
            }
        }

        let rawResultValue = rawValue.perform(Selector(("callWithArguments:")), with: rawArguments)?
            .takeUnretainedValue() as! NSObject
        return JSValue(rawResultValue)
    }

    func toString() -> String! {
        return rawValue.perform(Selector(("toString")))?
            .takeUnretainedValue() as? String
    }

    override var description: String { "JSValue()" }
}

extension JSValue {
    subscript(key: String) -> JSValue {
        get {
            let selector = Selector(("valueForProperty:"))
            let rawChildValue = rawValue.perform(selector, with: key)?
                .takeUnretainedValue() as! NSObject
            return JSValue(rawChildValue)
        }
        set {
            let selector = Selector(("setValue:forProperty:"))
            rawValue.perform(selector, with: newValue.rawValue, with: key)
        }
    }

    func define(name: String, value: JSValue) {
        let selector = Selector(("defineProperty:descriptor:"))
        rawValue.perform(selector, with: name, with: ["value": value.rawValue] as NSDictionary)
    }

    func define(name: String, function: @escaping () -> Any?) {
        let rawFunction: @convention(block) () -> Any? = {
            guard let result = function() else { return nil }

            if let value = result as? JSValue {
                return value.rawValue
            } else {
                return result
            }
        }

        let selector = Selector(("defineProperty:descriptor:"))
        rawValue.perform(selector, with: name, with: ["value": rawFunction] as NSDictionary)
    }
}

#if canImport(PlaygroundSupport)

extension JSContext: CustomPlaygroundDisplayConvertible {
    var playgroundDescription: Any { "" }
}

extension JSValue: CustomPlaygroundDisplayConvertible {
    var playgroundDescription: Any { "" }
}

#endif
