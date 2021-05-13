import Foundation

public struct LocalResource: _ExpressibleByFileReferenceLiteral {
    private let rawPath: String

    public init(fileReferenceLiteralResourceName path: String) {
        self.rawPath = path
    }

    public var path: String {
        rawPath.replacingOccurrences(of: "___", with: "/")
    }

    public var lastPathComponent: String {
        let path = self.path
        return path.lastIndex(of: "/").map { String(path[path.index(after: $0)...]) } ?? path
    }
    
    public var fileURL: URL {
        #if canImport(PlaygroundSupport)
        return URL(fileReferenceLiteralResourceName: rawPath)
        #else
        let relativePath = URL(fileURLWithPath: "../../../PublicResources/", isDirectory: true, relativeTo: URL(fileURLWithPath: #filePath))
        return URL(fileURLWithPath: rawPath, relativeTo: relativePath)
        #endif
    }
}
