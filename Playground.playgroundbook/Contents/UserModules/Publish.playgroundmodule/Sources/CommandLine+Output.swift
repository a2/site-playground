/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

internal extension CommandLine {
    enum OutputKind {
        case info
        case warning
        case error
        case success
    }

    static func output(_ string: String, as kind: OutputKind) {
        var string = string + "\n"

        if let emoji = kind.emoji {
            string = "\(emoji) \(string)"
        }

        print(string, terminator: "")
    }
}

private extension CommandLine.OutputKind {
    var emoji: Character? {
        switch self {
        case .info:
            return nil
        case .warning:
            return "⚠️"
        case .error:
            return "❌"
        case .success:
            return "✅"
        }
    }
}
