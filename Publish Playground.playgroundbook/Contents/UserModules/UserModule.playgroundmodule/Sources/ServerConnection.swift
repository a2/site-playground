// Based on https://rderik.com/blog/building-a-server-client-aplication-using-apple-s-network-framework/

import Foundation
import Network
import UniformTypeIdentifiers

class ServerConnection {
    // The TCP maximum package size is 64K 65536
    private static let maximumLength = 65536

    let connection: NWConnection
    let fileManager: InMemoryFileManager

    init(nwConnection: NWConnection, fileManager: InMemoryFileManager) {
        self.fileManager = fileManager
        self.connection = nwConnection
    }

    var didStopHandler: ((Error?) -> Void)?

    func start() {
        connection.stateUpdateHandler = { [weak self] in self?.stateDidChange(to: $0) }
        setupReceive()
        connection.start(queue: .main)
    }

    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error), .failed(let error):
            connectionDidFail(error: error)
        case .ready:
            break
        default:
            break
        }
    }

    private func setupReceive() {
        connection.receive(minimumIncompleteLength: 1, maximumLength: Self.maximumLength) { data, _, isComplete, error in
            if let data = data, !data.isEmpty {
                let message = String(decoding: data, as: UTF8.self)
                let firstLine = message.rangeOfCharacter(from: .newlines).map { range in String(message[..<range.lowerBound]) } ?? message

                let firstLineComponents = firstLine.components(separatedBy: " ")
                print(firstLineComponents.dropLast().joined(separator: " "))

                if firstLineComponents[0].caseInsensitiveCompare("GET") != .orderedSame {
                    let headerData = Data("""
                    HTTP/1.1 405 Method Not Allowed
                    Connection: close
                    """.utf8)
                    self.send(data: headerData, isFinal: true)
                } else {
                    let path = firstLineComponents[1]
                    let (targetPath, mimeType): (String, String) = {
                        guard let slashRange = path.range(of: "/", options: .backwards), slashRange.upperBound != path.endIndex,
                              let dotRange = path.range(of: ".", range: slashRange.upperBound ..< path.endIndex) else {

                            // Look for index.html
                            let pathToIndexHTML = path + (path.hasSuffix("/") ? "" : "/") + "index.html"
                            return (pathToIndexHTML, "text/html")
                        }

                        let uti = UTType(filenameExtension: String(path[dotRange.upperBound...]))
                        return (path, uti?.preferredMIMEType ?? "text/plain")
                    }()

                    if let contents = self.fileManager.contents(atPath: "/Output\(targetPath)") {
                        let headerData = Data("""
                        HTTP/1.1 200 OK
                        Content-Length: \(contents.count)
                        Content-Type: \(mimeType)
                        Connection: close\n\n
                        """.utf8)
                        self.send(data: headerData + contents, isFinal: true)
                    } else if let contents = self.fileManager.contents(atPath: "/Output/404/index.html") {
                        let headerData = Data("""
                        HTTP/1.1 404 Not Found
                        Content-Length: \(contents.count)
                        Content-Type: \(mimeType)
                        Connection: close\n\n
                        """.utf8)
                        self.send(data: headerData + contents, isFinal: true)
                    } else {
                        let headerData = Data("""
                        HTTP/1.1 404 Not Found
                        Connection: close
                        """.utf8)
                        self.send(data: headerData, isFinal: true)
                    }
                }
            }

            if isComplete {
                self.connectionDidEnd()
            } else if let error = error {
                self.connectionDidFail(error: error)
            } else {
                self.setupReceive()
            }
        }
    }

    func send(data: Data, isFinal: Bool = false) {
        let contentContext = isFinal ? NWConnection.ContentContext.finalMessage : .defaultMessage
        connection.send(content: data, contentContext: contentContext, completion: .contentProcessed({ error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }

            // Handle content processed
        }))
    }

    func stop() {}

    private func connectionDidFail(error: Error) {
        forceStop(error: error)
    }

    private func connectionDidEnd() {
        forceStop(error: nil)
    }

    private func forceStop(error: Error?) {
        connection.stateUpdateHandler = nil
        connection.cancel()

        didStopHandler?(error)
        didStopHandler = nil
    }
}

extension ServerConnection: Equatable {
    static func == (lhs: ServerConnection, rhs: ServerConnection) -> Bool {
        lhs.connection === rhs.connection && lhs.fileManager === rhs.fileManager
    }
}

extension ServerConnection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(connection))
        hasher.combine(ObjectIdentifier(fileManager))
    }
}
