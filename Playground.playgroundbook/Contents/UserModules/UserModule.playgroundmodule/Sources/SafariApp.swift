import Foundation
import Plot
import Publish

public struct SafariApp: App {
    public var name: String { "Safari" }
    public var location: AppLocation { .dock }

    public init() {}

    public var screen: Screen {
        Screen(statusBarStyle: .adaptive) {
            Div {
                Div {
                    Div {
                        Div("a2.io")
                    }.class("search-bar")
                }.class("navigation-bar")

                Div {
                    IFrame(url: "/", addBorder: false, allowFullScreen: false, enabledFeatureNames: [])
                        .attribute(named: "loading", value: "lazy")
                }.class("iframe-container")

                Div().class("toolbar")

                Link(url: "#") { EmptyComponent() }
                    .attribute(named: "title", value: "Return to Homescreen")
                    .class("home-indicator")
            }
        }
    }
}
