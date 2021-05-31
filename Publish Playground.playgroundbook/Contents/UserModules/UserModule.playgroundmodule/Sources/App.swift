import Foundation
import Plot
import Publish

public enum AppLocation {
    case homescreen
    case dock
}

public enum StatusBarStyle {
    case darkContent
    case lightContent

    public static var `default`: Self { .lightContent }
}

public struct Screen {
    public var statusBarStyle: StatusBarStyle
    public var body: Component

    public init(statusBarStyle: StatusBarStyle, @ComponentBuilder body: () -> Component) {
        self.statusBarStyle = statusBarStyle
        self.body = body()
    }
}

public protocol App {
    var id: String { get }
    var name: String { get }
    var location: AppLocation { get }

    var screen: Screen { get }
    var markdownPath: Path? { get }
}

public extension App {
    var id: String { name.lowercased().replacingOccurrences(of: " ", with: "-") }

    var markdownPath: Path? { "Apps/\(id).md" }

    var screen: Screen {
        Screen(statusBarStyle: .default) {
            Link("Return to Homescreen", url: "#")
                .attribute(named: "title", value: "Return to Homescreen")
        }
    }
}

public struct DefaultApp: App {
    public var name: String
    public var location: AppLocation
    public var statusBarStyle: StatusBarStyle

    public init(name: String, location: AppLocation, statusBarStyle: StatusBarStyle = .default) {
        self.name = name
        self.location = location
        self.statusBarStyle = statusBarStyle
    }

    public var screen: Screen {
        Screen(statusBarStyle: statusBarStyle) {
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
            DefaultApp(name: "Babelgum", location: .homescreen, statusBarStyle: .darkContent),
            DefaultApp(name: "Backgammon", location: .homescreen),
            DefaultApp(name: "Bean", location: .homescreen),
            DefaultApp(name: "Foursquare", location: .homescreen),
            DefaultApp(name: "Outlook", location: .homescreen),
            DefaultApp(name: "Rooms", location: .homescreen, statusBarStyle: .darkContent),
            DefaultApp(name: "Shutterstock", location: .homescreen, statusBarStyle: .darkContent),
            DefaultApp(name: "To Do", location: .homescreen),

            StubApp(name: "Messages", location: .dock),
            MailApp(),
            StubApp(name: "Safari", location: .dock),
            StubApp(name: "Music", location: .dock),
        ]
    }
}
