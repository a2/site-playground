import Foundation
import Publish

extension A2 {
    public struct App {
        public var name: String
        public var title: String?
        public var hasInvertedStatusBar: Bool

        public var id: String { name.lowercased().replacingOccurrences(of: " ", with: "-") }
        public var markdownPath: Path { Path("Apps/\(id).md") }

        public init(name: String, title: String? = nil, hasInvertedStatusBar: Bool = false) {
            self.name = name
            self.title = title
            self.hasInvertedStatusBar = hasInvertedStatusBar
        }
    }
}

public extension A2.Website {
    var homescreen: [A2.App] {
        [
            A2.App(name: "Babelgum", hasInvertedStatusBar: true),
            A2.App(name: "Backgammon", title: "Backgammon with Buddies"),
            A2.App(name: "Bean", title: "Bean, Small Planet"),
            A2.App(name: "Foursquare"),
            A2.App(name: "Outlook", title: "Microsoft Outlook"),
            A2.App(name: "Rooms", title: "Rooms, Facebook", hasInvertedStatusBar: true),
            A2.App(name: "Shutterstock", hasInvertedStatusBar: true),
            A2.App(name: "To Do", title: "Microsoft To Do"),
        ]
    }

    var dock: [A2.App] {
        [
            A2.App(name: "Messages"),
            A2.App(name: "Mail"),
            A2.App(name: "Safari"),
            A2.App(name: "Music"),
        ]
    }
}
