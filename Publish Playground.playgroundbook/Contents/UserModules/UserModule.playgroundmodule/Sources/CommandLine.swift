import Foundation

public extension CommandLine {
    static var defaultPort: UInt16 { 8000 }

    static let port: UInt16 = {
        #if canImport(PlaygroundSupport)
        return defaultPort
        #else
        let arguments = Self.arguments
        if let argumentIndex = arguments.firstIndex(where: { arg in arg == "--port" || arg == "-p" }), let valueIndex = arguments.index(argumentIndex, offsetBy: 1, limitedBy: arguments.endIndex), let port = UInt16(arguments[valueIndex]) {
            return port
        } else {
            return defaultPort
        }
        #endif
    }()

    static let shouldServe: Bool = {
        #if canImport(PlaygroundSupport)
        return true
        #else
        return arguments.contains(where: { arg in arg == "--serve" || arg == "-s" })
        #endif
    }()

    #if !canImport(PlaygroundSupport)
    static let shouldOpenBrowser: Bool = {
        return arguments.contains(where: { arg in arg == "--open" || arg == "-o" })
    }()

    static let exportPath: String? = {
        let arguments = Self.arguments
        guard let argumentIndex = arguments.firstIndex(where: { arg in arg == "--export" || arg == "-e" }), let valueIndex = arguments.index(argumentIndex, offsetBy: 1, limitedBy: arguments.endIndex) else {
            return nil
        }

        return (arguments[valueIndex] as NSString).expandingTildeInPath
    }()
    #endif

    static let isVerbose: Bool = {
        #if canImport(PlaygroundSupport)
        return true
        #else
        return arguments.contains(where: { arg in arg == "--verbose" || arg == "-v" })
        #endif
    }()
}
