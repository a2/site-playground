import Foundation

extension A2 {
    struct App {
        var name: String
        var title: String?
        var hasInvertedStatusBar: Bool

        var id: String { name.lowercased().replacingOccurrences(of: " ", with: "-") }

        init(name: String, title: String? = nil, hasInvertedStatusBar: Bool = true) {
            self.name = name
            self.title = title
            self.hasInvertedStatusBar = hasInvertedStatusBar
        }
    }
}

extension A2.Website {
    var homescreen: [A2.App] {
        [
            A2.App(name: "Babelgum", hasInvertedStatusBar: true),
            A2.App(name: "Backgammon", title: "Backgammon with Buddies"),
            A2.App(name: "Bean", title: "Bean, Small Planet"),
            A2.App(name: "Foursquare"),
            A2.App(name: "Outlook", title: "Microsoft Outlook"),
            A2.App(name: "Rooms", title: "Rooms, Facebook"),
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
