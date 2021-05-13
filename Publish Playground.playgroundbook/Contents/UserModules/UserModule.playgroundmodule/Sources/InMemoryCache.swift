import Files
import Foundation
import Publish

struct InMemoryFile {
    enum Contents {
        case data(Data)
        case file(URL)
    }

    var contents: Contents?

    init() {
        self.contents = nil
    }

    init(contents: Data?) {
        self.contents = contents.map(Contents.data)
    }

    init(contentsOf url: URL?) {
        self.contents = url.map(Contents.file)
    }

    func read() -> Data? {
        guard let contents = contents else { return nil }

        switch contents {
        case .data(let data):
            return data
        case .file(let url):
            return try? Data(contentsOf: url)
        }
    }
}

struct InMemoryFolder {
    var children: [String: InMemoryNode]

    init() {
        self.children = [:]
    }

    init(children: [String: InMemoryNode]) {
        self.children = children
    }

    fileprivate func descendantFiles() -> [(String, InMemoryFile)] {
        var files = [(String, InMemoryFile)]()
        files.reserveCapacity(children.count)

        for (childPath, node) in children {
            switch node {
            case .folder(let folder):
                let sequence = folder.descendantFiles().lazy.map { (childPath + "/" + $0, $1) }
                files.append(contentsOf: sequence)
            case .file(let file):
                files.append((childPath, file))
            }
        }

        return files
    }
}

enum InMemoryError: Error {
    case noSuchItem
    case expectedFile
    case expectedFolder
}

enum InMemoryNode {
    case file(InMemoryFile)
    case folder(InMemoryFolder)

    mutating func addNode(_ node: InMemoryNode, named name: String) throws {
        try mutateChildren { children in
            assert(children[name] == nil, "Child named \(name) already exists")
            children[name] = node
        }
    }

    mutating func removeNode(named name: String) throws -> InMemoryNode? {
        try mutateChildren { children in
            children.removeValue(forKey: name)
        }
    }

    mutating func mutateChildren<R>(_ mutation: (_ children: inout [String: InMemoryNode]) -> R) throws -> R {
        switch self {
        case .folder(var folder):
            let result = mutation(&folder.children)
            self = .folder(folder)
            return result
        default:
            throw InMemoryError.expectedFolder
        }
    }
}

class InMemoryCache {
    var root: InMemoryFolder

    init() {
        self.root = InMemoryFolder()
    }

    func node(atPath path: String) -> InMemoryNode? {
        assert(path.hasPrefix("/"), "Path must be absolute")

        var node: InMemoryFolder = root
        if path != "/" {
            for component in path.dropFirst().components(separatedBy: "/") {
                guard let nodeAtComponent = node.children[component] else {
                    return nil
                }

                guard case .folder(let folder) = nodeAtComponent else {
                    return nodeAtComponent
                }

                node = folder
            }
        }

        return .folder(node)
    }

    func setNode(_ node: InMemoryNode?, atPath path: String) throws {
        if path == "/" {
            root = {
                switch node {
                case .folder(let folder)?:
                    return folder
                case .file?:
                    assertionFailure("Cannot set file as root")
                    return InMemoryFolder()
                case .none:
                    return InMemoryFolder()
                }
            }()
        } else {
            let parentPath = (path as NSString).deletingLastPathComponent

            guard var parent = self.node(atPath: parentPath) else {
                throw InMemoryError.noSuchItem
            }

            try parent.mutateChildren { children in
                children[(path as NSString).lastPathComponent] = node
            }

            try setNode(parent, atPath: parentPath)
        }
    }
}

public class InMemoryFileManager: Files.FileManager {
    let cache: InMemoryCache

    public let currentDirectoryPath: String

    public init() {
        self.cache = InMemoryCache()
        self.currentDirectoryPath = "/"
    }

    private func prefixed(_ path: String) -> String {
        ((currentDirectoryPath as NSString).appendingPathComponent(path) as NSString).standardizingPath
    }

    public func subpathsOfDirectory(atPath path: String) throws -> [String] {
        assert(path.hasPrefix("/"), "Path must be absolute")

        guard case .folder(let folder) = cache.node(atPath: prefixed(path)) else {
            throw InMemoryError.noSuchItem
        }

        let separator = path.hasSuffix("/") ? "" : "/"
        return folder.descendantFiles().map { childPath, _ in path + separator + childPath }
    }

    public func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any] {
        guard cache.node(atPath: prefixed(path)) != nil else {
            throw InMemoryError.noSuchItem
        }

        return [:]
    }

    public func contentsOfDirectory(atPath path: String) throws -> [String] {
        guard case .folder(let folder) = cache.node(atPath: prefixed(path)) else {
            throw InMemoryError.noSuchItem
        }

        return Array(folder.children.keys)
    }

    public func copyItem(atPath sourcePath: String, toPath destinationPath: String) throws {
        guard let node = cache.node(atPath: prefixed(sourcePath)) else {
            throw InMemoryError.noSuchItem
        }

        try cache.setNode(node, atPath: prefixed(destinationPath))
    }

    private func createDirectoryRecursive(atPath prefixedPath: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws {
        if createIntermediates {
            let components = (prefixedPath.dropFirst() as NSString).pathComponents
            if components.count > 1 {
                let intermediatePath: String = {
                    let path = NSString.path(withComponents: Array(components.dropLast()))
                    return path.hasPrefix("/") ? path : "/" + path
                }()
                try createDirectoryRecursive(atPath: intermediatePath, withIntermediateDirectories: true, attributes: attributes)
            }
        } 

        switch cache.node(atPath: prefixedPath) {
        case .file?:
            throw InMemoryError.expectedFolder
        case .folder?:
            break
        case .none:
            try cache.setNode(.folder(InMemoryFolder()), atPath: prefixedPath)
        }
    }

    public func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws {
        try createDirectoryRecursive(atPath: prefixed(path), withIntermediateDirectories: createIntermediates, attributes: attributes)
    }

    public func createFile(atPath path: String, contentsOf url: URL) -> Bool {
        do {
            try cache.setNode(.file(InMemoryFile(contentsOf: url)), atPath: prefixed(path))
            return true
        } catch {
            return false
        }
    }

    public func createFile(atPath path: String, contents data: Data?, attributes: [FileAttributeKey : Any]?) -> Bool {
        do {
            try cache.setNode(.file(InMemoryFile(contents: data)), atPath: prefixed(path))
            return true
        } catch {
            return false
        }
    }

    public func fileExists(atPath path: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool {
        guard let node = cache.node(atPath: prefixed(path)) else {
            return false
        }

        if let isDirectory = isDirectory {
            switch node {
            case .folder:
                isDirectory.pointee = true
            case .file:
                isDirectory.pointee = false
            }
        }

        return true
    }

    public func removeItem(atPath path: String) throws {
        try cache.setNode(nil, atPath: prefixed(path))
    }

    public func moveItem(atPath sourcePath: String, toPath destinationPath: String) throws {
        let prefixedSourcePath = prefixed(sourcePath)
        let node = cache.node(atPath: prefixedSourcePath)
        try cache.setNode(nil, atPath: prefixedSourcePath)
        try cache.setNode(node, atPath: prefixed(destinationPath))
    }

    public func contents(atPath path: String) -> Data? {
        switch cache.node(atPath: path) {
        case .file(let file)?:
            return file.read()
        case .folder?, .none:
            return nil
        }
    }

    public func setContents(_ contents: Data?, atPath path: String) throws {
        switch cache.node(atPath: path) {
        case .folder:
            assertionFailure("Cannot set contents at folder path")
        case .none, .file:
            break
        }

        try cache.setNode(.file(InMemoryFile(contents: contents)), atPath: path)
    }

    public func setContents(from url: URL, atPath path: String) throws {
        switch cache.node(atPath: path) {
        case .folder:
            assertionFailure("Cannot set contents at folder path")
        case .none, .file:
            break
        }

        try cache.setNode(.file(InMemoryFile(contentsOf: url)), atPath: path)
    }

    public func subsumeItems(atPath sourcePath: String, into destinationPath: String, from otherFileManager: Files.FileManager) throws {
        for childItemPath in try otherFileManager.contentsOfDirectory(atPath: sourcePath) {
            var isDirectory: ObjCBool = true
            let exists = otherFileManager.fileExists(atPath: childItemPath, isDirectory: &isDirectory)
            assert(exists, "File \(childItemPath) returned as contents of directory but does not exist")

            if isDirectory.boolValue {
                try subsumeItems(atPath: "\(sourcePath)/\(childItemPath)", into: "\(destinationPath)/\(childItemPath)", from: otherFileManager)
            } else {
                let contents = otherFileManager.contents(atPath: childItemPath)
                _ = createFile(atPath: childItemPath, contents: contents)
            }
        }
    }
}
