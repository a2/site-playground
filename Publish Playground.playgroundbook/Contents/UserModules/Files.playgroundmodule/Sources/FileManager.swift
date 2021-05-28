import Foundation

public protocol FileManager {
    var currentDirectoryPath: String { get }
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any]
    func contentsOfDirectory(atPath path: String) throws -> [String]
    func subpathsOfDirectory(atPath path: String) throws -> [String]
    func copyItem(atPath sourcePath: String, toPath destinationPath: String) throws
    func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws
    func createFile(atPath path: String, contents data: Data?, attributes: [FileAttributeKey: Any]?) -> Bool
    func fileExists(atPath path: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool
    func removeItem(atPath path: String) throws
    func moveItem(atPath sourcePath: String, toPath destinationPath: String) throws

    func contents(atPath path: String) -> Data?
    func setContents(_ contents: Data?, atPath path: String) throws

    #if os(macOS)
    var userDocumentsDirectoryPath: String { get }
    var userLibraryDirectoryPath: String { get }
    #endif
}

public extension FileManager {
    func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool) throws {
        try createDirectory(atPath: path, withIntermediateDirectories: createIntermediates, attributes: nil)
    }

    func createFile(atPath path: String, contents data: Data?) -> Bool {
        createFile(atPath: path, contents: data, attributes: nil)
    }

    func setContents(_ contents: Data?, atPath path: String) throws {
        let url = URL(fileURLWithPath: path)
        try (contents ?? Data())?.write(to: url)
    }

    #if os(macOS)
    var userDocumentsDirectoryPath: String {
        ("~/Documents" as NSString).expandingTildeInPath
    }

    var userLibraryDirectoryPath: String {
        ("~/Library" as NSString).expandingTildeInPath
    }
    #endif

    func copyItem(atPath sourcePath: String, toPath destinationPath: String, in otherFileManager: FileManager) throws {
        var isDirectory: ObjCBool = true
        let fileExists = self.fileExists(atPath: sourcePath, isDirectory: &isDirectory)
        assert(fileExists, "File \(sourcePath) does not exist")

        if isDirectory.boolValue {
            try otherFileManager.createDirectory(atPath: destinationPath, withIntermediateDirectories: true)
            for childItemPath in try contentsOfDirectory(atPath: sourcePath) {
                let childSourcePath = sourcePath + (sourcePath.hasSuffix("/") ? "" : "/") + childItemPath
                let childDestinationPath = destinationPath + (destinationPath.hasSuffix("/") ? "" : "/") + childItemPath
                try copyItem(atPath: childSourcePath, toPath: childDestinationPath, in: otherFileManager)
            }
        } else {
            _ = otherFileManager.createFile(atPath: destinationPath, contents: contents(atPath: sourcePath)!)
        }
    }
}

public var defaultFileManager: FileManager = Foundation.FileManager.default
extension Foundation.FileManager: FileManager {}
