// Based on https://rderik.com/blog/building-a-server-client-aplication-using-apple-s-network-framework/

#if canImport(Network)

import Foundation
import Network

public class Server {
    let fileManager: InMemoryFileManager
    var listener: NWListener?

    private var activeConnections: Set<ServerConnection> = []

    public init(fileManager: InMemoryFileManager) {
        self.fileManager = fileManager
    }

    public func start(port: UInt16) throws {
        print("Server starting...")
        let listener = try NWListener(using: .tcp, on: NWEndpoint.Port(rawValue: port)!)
        listener.stateUpdateHandler = { [weak self] in self?.stateDidChange(to: $0) }
        listener.newConnectionHandler = { [weak self] in self?.handleNewConnection($0) }
        listener.start(queue: .main)
        self.listener = listener
    }

    func stateDidChange(to newState: NWListener.State) {
        switch newState {
        case .ready:
            print("Server ready on port \(listener!.port!)")
        case .failed(let error):
            print("Server failure, error: \(error.localizedDescription)")
        default:
            break
        }
    }

    private func handleNewConnection(_ nwConnection: NWConnection) {
        let connection = ServerConnection(nwConnection: nwConnection, fileManager: fileManager)
        connection.didStopHandler = { [weak self] _ in self?.connectionDidStop(connection) }
        connection.start()
        activeConnections.insert(connection)
    }

    private func connectionDidStop(_ connection: ServerConnection) {
        activeConnections.remove(connection)?.stop()
    }

    private func stop() {
        activeConnections.forEach { $0.stop() }
        activeConnections.removeAll()

        listener?.cancel()
        listener = nil
    }
}

#endif
