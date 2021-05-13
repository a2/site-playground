import Publish
import Plot

struct Phone: Component {
    let homescreen: [A2.App]
    let dock: [A2.App]

    init(homescreen: [A2.App], dock: [A2.App]) {
        self.homescreen = homescreen
        self.dock = dock
    }

    @ComponentBuilder var body: Component {
        Div {
            Div {
                let buttons = ["power", "mute", "volume-up", "volume-down"]
                ComponentGroup(members: buttons.map { button in Div().class(button) })
            }.class("buttons")

            Div {
                let vertical = ["top", "bottom"]
                let horizontal = ["left", "center", "right"]
                ComponentGroup(members: vertical.flatMap { v in
                    horizontal.map { h in Div().class([v, h].joined(separator: " ")) }
                })
            }.class("bands")

            Div {
                Div().class("notch")

                Div {
                    Div("9:41").class("time")
                    Element(name: "svg") {
                        Element(name: "path") { EmptyComponent() }
                            .class("path-stroke animated")
                            .attribute(named: "d", value: "M61 .8c1 0 1.3.1 1.7.3.4.2.7.5.8.8.2.4.3.8.3 1.9h0v4.4c0 1.1 0 1.5-.3 1.9a2 2 0 01-.8.8c-.4.2-.7.3-1.8.3h0-15.1c-1.1 0-1.5-.1-1.9-.3a2 2 0 01-.8-.8c-.2-.4-.3-.8-.3-1.9h0V3.8c0-1.1.1-1.5.3-1.9l.8-.8c.4-.2.8-.3 1.9-.3h0z")
                            .attribute(named: "fill", value: "none")
                            .attribute(named: "opacity", value: "0.3")
                            .attribute(named: "stroke", value: "#fff")

                        Element(name: "path") { EmptyComponent() }
                            .class("path-fill animated")
                            .attribute(named: "d", value: "M65.3 4v4a2.2 2.2 0 000-4")
                            .attribute(named: "fill", value: "#fff")
                            .attribute(named: "opacity", value: "0.4")

                        Element(name: "path") { EmptyComponent() }
                            .class("path-fill animated")
                            .attribute(named: "d", value: "M46 2.3h14.6c.6 0 .8.1 1 .2.3.1.4.3.6.5l.1 1v4l-.1 1-.5.5-1 .2H46c-.6 0-.8-.1-1-.2l-.5-.5c-.1-.2-.2-.4-.2-1V4c0-.6.1-.8.2-1l.5-.5c.2-.1.4-.2 1-.2zM29.7 2.6c2.2 0 4.3.9 6 2.4 0 .1.3.1.4 0l1.1-1.2a.3.3 0 000-.4c-4.2-4-10.9-4-15.1 0a.3.3 0 000 .4L23.3 5c0 .1.3.1.4 0a8.7 8.7 0 016-2.4zm0 3.8A5 5 0 0133 7.7c.1.1.3.1.4 0l1.2-1.2a.3.3 0 000-.4 7.2 7.2 0 00-9.8 0 .3.3 0 000 .4l1.1 1.2h.5a5 5 0 013.3-1.3zm2.2 2.8a.3.3 0 000-.4c-1.3-1.1-3.2-1.1-4.5 0a.3.3 0 000 .4l2 2a.3.3 0 00.5 0l2-2zM1 7.3h1c.6 0 1 .5 1 1v2c0 .6-.4 1-1 1H1a1 1 0 01-1-1v-2c0-.5.4-1 1-1zm4.7-2h1c.5 0 1 .5 1 1v4c0 .6-.5 1-1 1h-1a1 1 0 01-1-1v-4c0-.5.4-1 1-1zM10.3 3h1c.6 0 1 .4 1 1v6.3c0 .6-.4 1-1 1h-1a1 1 0 01-1-1V4c0-.6.5-1 1-1zM15 .7h1c.6 0 1 .4 1 1v8.6c0 .6-.4 1-1 1h-1a1 1 0 01-1-1V1.7c0-.6.4-1 1-1z")
                            .attribute(named: "fill", value: "#fff")
                    }
                    .class("status")
                    .attribute(named: "viewbox", value: "0 0 67 12")
                    .attribute(named: "xmls", value: "http://www.w3.org/2000/svg")
                }.class("status-bar animated")

                Div {
                    Div().class("background")
                    Div {
                        List(homescreen) { app in
                            Link(app.name, url: "#\(app.id)")
                                .class("app app-\(app.id)")
                                .attribute(named: "role", value: "button")
                                .attribute(named: "title", value: app.name)
                        }
                    }.class("icons animated")
                    Div {
                        List(dock) { app in
                            Link(app.name, url: "#\(app.id)")
                                .class("app app-\(app.id)")
                                .attribute(named: "role", value: "button")
                                .attribute(named: "title", value: app.name)
                        }
                    }.class("dock")
                }.class("homescreen animated")

                ComponentGroup(members: homescreen.map { app in
                    Link("Return to Homescreen", url: "#")
                        .class("screen screen-\(app.id) animated")
                        .attribute(named: "title", value: "Return to Homescreen")
                })
            }.class("display")
        }
        .class("phone")
    }
}
