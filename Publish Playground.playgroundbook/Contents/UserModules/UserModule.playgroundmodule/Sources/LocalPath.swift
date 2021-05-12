import Foundation

public func localFile(named fileName: String) -> URL {
    let fileName = fileName.replacingOccurrences(of: "/", with: "___")
    #if canImport(PlaygroundSupport)
    return URL(fileReferenceLiteralResourceName: fileName)
    #else
    return URL(fileURLWithPath: "../../../PublicResources/" + fileName, relativeTo: URL(fileURLWithPath: #filePath))
        .standardizedFileURL
    #endif
}
