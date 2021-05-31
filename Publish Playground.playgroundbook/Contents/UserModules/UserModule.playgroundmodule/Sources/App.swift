import Foundation
import Plot
import Publish

public enum AppLocation {
    case homescreen
    case dock
}

public struct Screen {
    public var hasInvertedStatusBar: Bool
    public var body: Component

    public init(hasInvertedStatusBar: Bool, @ComponentBuilder body: () -> Component) {
        self.hasInvertedStatusBar = hasInvertedStatusBar
        self.body = body()
    }
}

public protocol App {
    var id: String { get }
    var name: String { get }
    var title: String? { get }
    var location: AppLocation { get }

    var screen: Screen { get }
    var markdownPath: Path? { get }
}

public extension App {
    var id: String { name.lowercased().replacingOccurrences(of: " ", with: "-") }

    var markdownPath: Path? { "Apps/\(id).md" }

    var screen: Screen {
        Screen(hasInvertedStatusBar: false) {
            Link("Return to Homescreen", url: "#")
                .attribute(named: "title", value: "Return to Homescreen")
        }
    }
}

public struct DefaultApp: App {
    public var name: String
    public var title: String?
    public var location: AppLocation
    public var hasInvertedStatusBar: Bool

    public init(name: String, title: String? = nil, location: AppLocation, hasInvertedStatusBar: Bool = false) {
        self.name = name
        self.title = title
        self.location = location
        self.hasInvertedStatusBar = hasInvertedStatusBar
    }

    public var screen: Screen {
        Screen(hasInvertedStatusBar: hasInvertedStatusBar) {
            Link("Return to Homescreen", url: "#")
                .attribute(named: "title", value: "Return to Homescreen")
        }
    }
}

public struct StubApp: App {
    public var name: String
    public var title: String?
    public var location: AppLocation
    public var hasInvertedStatusBar: Bool { false }

    public init(name: String, title: String? = nil, location: AppLocation) {
        self.name = name
        self.title = title
        self.location = location
    }
}

public extension A2.Website {
    var apps: [App] {
        [
            DefaultApp(name: "Babelgum", location: .homescreen, hasInvertedStatusBar: true),
            DefaultApp(name: "Backgammon", title: "Backgammon with Buddies", location: .homescreen),
            DefaultApp(name: "Bean", title: "Bean, Small Planet", location: .homescreen),
            DefaultApp(name: "Foursquare", location: .homescreen),
            DefaultApp(name: "Outlook", title: "Microsoft Outlook", location: .homescreen),
            DefaultApp(name: "Rooms", title: "Rooms, Facebook", location: .homescreen, hasInvertedStatusBar: true),
            DefaultApp(name: "Shutterstock", location: .homescreen, hasInvertedStatusBar: true),
            DefaultApp(name: "To Do", title: "Microsoft To Do", location: .homescreen),

            StubApp(name: "Messages", location: .dock),
            MailApp(),
            StubApp(name: "Safari", location: .dock),
            StubApp(name: "Music", location: .dock),
        ]
    }
}
