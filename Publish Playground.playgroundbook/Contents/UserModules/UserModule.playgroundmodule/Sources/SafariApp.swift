import Foundation
import Plot
import Publish

public struct SafariApp: App {
    public var name: String { "Safari" }
    public var location: AppLocation { .dock }

    public init() {}

    public var screen: Screen {
        Screen(statusBarStyle: .darkContent) {
            Div {
                Div {
                    Div {
                        Div("a2.io")
                    }.class("search-bar")
                }.class("navigation-bar")

                Div {
                    IFrame(url: "/", addBorder: false, allowFullScreen: false, enabledFeatureNames: [])
                        .attribute(named: "height", value: "100%")
                        .attribute(named: "loading", value: "lazy")
                        .attribute(named: "width", value: "100%")
                }.class("iframe-container")

                Div().class("toolbar")

                Link(url: "#") { EmptyComponent() }
                    .attribute(named: "title", value: "Return to Homescreen")
                    .class("home-indicator")
            }
        }
    }
}
