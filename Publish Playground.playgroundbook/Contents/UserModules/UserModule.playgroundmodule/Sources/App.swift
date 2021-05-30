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

public struct MailApp: App {
    public var name: String { "Mail" }
    public var title: String? { nil }
    public var location: AppLocation { .dock }

    public init() {}

    public var screen: Screen {
        Screen(hasInvertedStatusBar: false) {
            let factor: Decimal = 0.02
            Div {
                Div().style("background-color: #e0e0e0; width: calc(100% - \(Decimal(48) * factor)rem); height: calc(100% - \(Decimal(140) * factor)rem); position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); border-radius: \(Decimal(30) * factor)rem")
                Div {
                    Link("Cancel", url: "#")
                        .style("color: #3478F6; display: block; margin: \(Decimal(65) * factor)rem \(Decimal(50) * factor)rem; font-size: \(Decimal(48) * factor)rem; text-decoration: none;")

                    Div {
                        Span("New Message")
                            .style("float: left; font-weight: bold; display: block; font-size: \(Decimal(96) * factor)rem;")

                        Link(url: "") {
                            Element(name: "svg") {
                                Element(name: "path") { EmptyComponent() }
                                    .attribute(named: "d", value: "M49.80467,99.6094 C77.05077,99.6094 99.60977,77.00196 99.60977,49.8047 C99.60977,22.5586 77.00197,0 49.75587,0 C22.55857,0 0,22.5586 0,49.8047 C0,77.00196 22.60747,99.6094 49.80467,99.6094 Z M49.80467,75 C47.60747,75 45.99607,73.4375 45.99607,71.1914 L45.99607,46.1426 L46.43557,35.4492 L41.40627,41.5039 L35.44927,47.5098 C34.76567,48.1934 33.78907,48.6328 32.76367,48.6328 C30.66407,48.6328 29.10157,47.0215 29.10157,44.9707 C29.10157,43.8965 29.39457,43.0176 30.07817,42.334 L46.87497,25.5859 C47.90037,24.5606 48.73047,24.1699 49.80467,24.1699 C50.92777,24.1699 51.80667,24.6094 52.78317,25.5859 L69.53127,42.334 C70.21487,43.0176 70.60547,43.8965 70.60547,44.9707 C70.60547,47.0215 68.99417,48.6328 66.89457,48.6328 C65.82027,48.6328 64.89257,48.2422 64.20897,47.5098 L58.30077,41.5039 L53.17387,35.4004 L53.61327,46.1426 L53.61327,71.1914 C53.61327,73.4375 52.05077,75 49.80467,75 Z")
                                    .attribute(named: "fill", value: "#3478F6")
                                    .attribute(named: "fill-rule", value: "nonzero")
                            }
                            .attribute(named: "viewBox", value: "0 0 100 101")
                            .attribute(named: "version", value: "1.1")
                            .attribute(named: "xmlns", value: "http://www.w3.org/2000/svg")
                            .attribute(named: "xmlns:xlink", value: "http://www.w3.org/1999/xlink")
                        }
                        .style("float: right; width: \(Decimal(107) * factor)rem; width: \(Decimal(107) * factor)rem")
                    }
                    .class("clearfix")
                    .style("padding: \(Decimal(40) * factor)rem \(Decimal(50) * factor)rem")

                    Div {
                        Span("To:").style("color: #8A8A8D")
                        Span("Alexsander Akers")
                    }
                    .style("padding: \(Decimal(40) * factor)rem 0; margin: 0 \(Decimal(50) * factor)rem; font-size: \(Decimal(48) * factor)rem; border-bottom: \(Decimal(1) * factor)rem solid #c6c6c8")

                    Div {
                        Label("Subject:") {
                            EmptyComponent()
                        }
                        .attribute(named: "for", value: "subject")
                        .style("color: #8A8A8D; margin-right: \(Decimal(16) * factor)rem")

                        Input(type: .text, name: "subject", value: nil, isRequired: true, placeholder: "What’s up?")
                            .style("flex: 1; border: 0; font-size: \(Decimal(48) * factor)rem; padding: 0; margin: 0")
                    }
                    .style("display: flex; padding: \(Decimal(40) * factor)rem 0; margin: 0 \(Decimal(50) * factor)rem; font-size: \(Decimal(48) * factor)rem; border-bottom: \(Decimal(1) * factor)rem solid #c6c6c8")

                    Div {
                        Node.div()
                        .attribute(named: "contenteditable", value: "", ignoreValueIfEmpty: false)
                        .attribute(named: "role", value: "textbox")
                        .class("textarea")
                        .style("min-height: \(Decimal(180) * factor)rem; max-height: \(Decimal(1000) * factor)rem; white-space: pre-wrap; overflow: scroll")

                        Div("Sent from my iPhone").style("margin-top: \(Decimal(16) * factor)rem")
                    }
                    .style("padding: \(Decimal(40) * factor)rem \(Decimal(50) * factor)rem; font-size: \(Decimal(48) * factor)rem")
                }.style("background-color: #fff; width: 100%; height: calc(100% - \(Decimal(170) * factor)rem); position: absolute; bottom: 0; z-index: 1; border-radius: \(Decimal(30) * factor)rem")
            }.style("background-color: black")
        }
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
