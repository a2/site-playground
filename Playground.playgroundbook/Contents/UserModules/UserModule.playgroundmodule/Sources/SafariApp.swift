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

                Div {
                    Link(url: "#") {
                        Element(name: "svg") {
                            Element(name: "path") { EmptyComponent() }
                                .attribute(named: "d", value: "M25.1 31c.5 0 .8-.3.8-.8 0-.2 0-.4-.2-.5l-8-7.7 8-7.6c.2-.2.2-.4.2-.6 0-.5-.3-.8-.8-.8-.2 0-.4 0-.6.2L16 21.4l-.3.6.3.6 8.5 8.2.6.3z")
                                .attribute(named: "fill", value: "#0a7aff")
                        }
                        .attribute(named: "viewbox", value: "0 0 44 44")
                        .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")
                    }
                    .attribute(named: "title", value: "Back")

                    Element(name: "svg") {
                        Element(name: "path") { EmptyComponent() }
                            .attribute(named: "d", value: "M19.7 31c.2 0 .4 0 .5-.2l8.6-8.2.2-.6c0-.2 0-.4-.2-.6l-8.6-8.2a.8.8 0 00-.5-.2c-.5 0-.9.3-.9.8l.3.6 8 7.6-8 7.7c-.2.1-.3.3-.3.5 0 .5.4.9.9.9z")
                            .attribute(named: "fill", value: "#0a7aff")
                    }
                    .attribute(named: "aria-disabled", value: "true")
                    .attribute(named: "aria-label", value: "Forward")
                    .attribute(named: "viewbox", value: "0 0 44 44")
                    .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")

                    Element(name: "svg") {
                        Element(name: "path") { EmptyComponent() }
                            .attribute(named: "d", value: "M22.7 24.9c.4 0 .8-.3.8-.7V12.9l-.1-1.6.9.9L26 14c.1.2.3.2.5.2.4 0 .7-.2.7-.6L27 13l-3.7-3.6a.7.7 0 00-.6-.2c-.2 0-.3 0-.5.2l-3.7 3.6c-.2.1-.2.3-.2.5 0 .4.2.6.6.6.2 0 .4 0 .5-.2l1.8-1.8.9-1L22 13v11.3c0 .4.3.7.7.7zm6.2 8.3c2.1 0 3.2-1 3.2-3.2V19.2c0-2.2-1-3.2-3.2-3.2h-3v1.4h3c1 0 1.7.6 1.7 1.8V30c0 1.2-.6 1.8-1.8 1.8H16.6c-1.2 0-1.8-.6-1.8-1.8V19.2c0-1.2.6-1.8 1.8-1.8h3V16h-3c-2.2 0-3.3 1-3.3 3.2V30c0 2.1 1.1 3.2 3.3 3.2h12.3z")
                            .attribute(named: "fill", value: "#bfbfbf")
                    }
                    .attribute(named: "aria-disabled", value: "true")
                    .attribute(named: "aria-label", value: "Share")
                    .attribute(named: "viewbox", value: "0 0 44 44")
                    .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")

                    Element(name: "svg") {
                        Element(name: "path") { EmptyComponent() }
                            .attribute(named: "d", value: "M22.8 31.8c.4 0 .7-.2 1-.5a6.4 6.4 0 014.5-1.9c1.7 0 3.2.6 4.4 1.5.3.2.6.4.9.4.5 0 1-.3 1-1V15.6l-.1-.5c-1-1.6-3.4-3-6.2-3-2.4 0-4.4 1-5.5 2.4-1-1.4-3-2.4-5.4-2.4-2.8 0-5.2 1.4-6.2 3l-.1.5v14.5c0 .8.5 1 1 1l1-.3a7.2 7.2 0 014.3-1.5c1.6 0 3.2.7 4.4 1.9.4.3.7.5 1 .5zm-.7-2.2c-1-.9-2.8-1.6-4.7-1.6-2 0-3.7.5-4.9 1.4V16c1-1.3 2.9-2.2 4.9-2.2 2.1 0 3.9.9 4.7 2.3v13.6zm1.5 0V16c.8-1.4 2.6-2.3 4.7-2.3 2 0 4 .9 4.8 2.2v13.5a8 8 0 00-4.8-1.4c-2 0-3.7.7-4.7 1.6z")
                            .attribute(named: "fill", value: "#bfbfbf")
                    }
                    .attribute(named: "aria-disabled", value: "true")
                    .attribute(named: "aria-label", value: "Bookmarks")
                    .attribute(named: "viewbox", value: "0 0 44 44")
                    .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")

                    Element(name: "svg") {
                        Element(name: "path") { EmptyComponent() }
                            .attribute(named: "d", value: "M30.2 33c2.1 0 3.2-1 3.2-3.2V19c0-2.1-1-3.2-3.2-3.2h-2v-1.6c0-2-1-3.2-3.2-3.2H14.2c-2.1 0-3.2 1.1-3.2 3.2V25c0 2.2 1 3.2 3.2 3.2h2v1.6c0 2.1 1 3.2 3.2 3.2h10.8zm-14-6.2h-2c-1.1 0-1.7-.6-1.7-1.8V14.3c0-1.2.6-1.8 1.8-1.8H25c1.1 0 1.7.6 1.7 1.8v1.5h-7.3c-2.1 0-3.2 1-3.2 3.2v7.8zm14 4.8H19.5c-1.2 0-1.8-.7-1.8-1.9V19.1c0-1.2.6-1.8 1.8-1.8h10.7c1 0 1.7.6 1.7 1.8v10.6c0 1.2-.6 1.9-1.7 1.9z")
                            .attribute(named: "fill", value: "#bfbfbf")
                    }
                    .attribute(named: "aria-disabled", value: "true")
                    .attribute(named: "aria-label", value: "Tabs")
                    .attribute(named: "viewbox", value: "0 0 44 44")
                    .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")
                }.class("toolbar")

                Link(url: "#") { EmptyComponent() }
                    .attribute(named: "title", value: "Return to Homescreen")
                    .class("home-indicator")
            }
        }
    }
}
