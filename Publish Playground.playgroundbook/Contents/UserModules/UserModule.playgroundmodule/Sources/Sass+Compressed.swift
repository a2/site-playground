import AppleArchive
import Foundation
import System

fileprivate extension ArchiveHeader.FieldKey {
    static let DAT = ArchiveHeader.FieldKey("DAT")
}

public extension Sass {
    convenience init?(compressedScriptURL: URL) {
        guard let sourcePath = FilePath(compressedScriptURL) else { return nil }
        guard let readFileStream = ArchiveByteStream.fileStream(path: sourcePath, mode: .readOnly, options: [], permissions: FilePermissions(rawValue: 0o644)) else { return nil }
        defer { try? readFileStream.close() }

        guard let decompressStream = ArchiveByteStream.decompressionStream(readingFrom: readFileStream) else { return nil }
        defer { try? decompressStream.close() }

        guard let decodeStream = ArchiveStream.decodeStream(readingFrom: decompressStream) else { return nil }
        defer { try? decodeStream.close() }

        let header: ArchiveHeader
        do {
            header = try decodeStream.readHeader()!
        } catch {
            return nil
        }

        let byteCount: UInt64
        switch header.field(forKey: .DAT) {
        case .blob(_, let size, _) where size > 0:
            byteCount = size
        default:
            return nil
        }

        let rawBufferPointer = UnsafeMutableRawBufferPointer.allocate(byteCount: Int(byteCount), alignment: MemoryLayout<UTF8>.alignment)
        defer { rawBufferPointer.deallocate() }

        do {
            try decodeStream.readBlob(key: .DAT, into: rawBufferPointer)
        } catch {
            return nil
        }

        let typedPointer = rawBufferPointer.bindMemory(to: CChar.self)
        guard let baseAddress = typedPointer.baseAddress else { return nil }

        self.init(scriptSource: String(cString: baseAddress))
    }
}
