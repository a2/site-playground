import Foundation
import Plot
import Publish

private struct Field: Component {
    var name: String
    var title: String
    var type: HTMLInputType
    var placeholder: String?

    @ComponentBuilder var body: Component {
        Div {
            Label(title) { EmptyComponent() }
                .attribute(named: "for", value: name)
            Input(type: type, name: name, isRequired: true, placeholder: placeholder)
        }
        .class("fieldset flex")

        HorizontalRule()
    }
}

public struct MailApp: App {
    public var name: String { "Mail" }
    public var location: AppLocation { .dock }

    public init() {}

    public var screen: Screen {
        Screen(statusBarStyle: .lightContent) {
            Div {
                Div().class("page background")
                Div {
                    Link("Cancel", url: "#").class("cancel")

                    Form(url: "/", method: .post) {
                        Header {
                            Span("New Message").class("title")

                            Button {
                                Element(name: "svg") {
                                    Element(name: "path") { EmptyComponent() }
                                        .attribute(named: "d", value: "M50 0a50 50 0 110 100A50 50 0 0150 0zm-.2 24.2c-1 0-1.9.4-3 1.4L30.2 42.3c-.7.7-1 1.6-1 2.7 0 2 1.6 3.6 3.7 3.6 1 0 2-.4 2.6-1l6-6.1 5-6L46 46v25c0 2.3 1.6 3.9 3.8 3.9 2.3 0 3.8-1.6 3.8-3.8v-25l-.4-10.8 5.1 6.1 6 6c.6.7 1.5 1.1 2.6 1.1 2 0 3.7-1.6 3.7-3.6 0-1.1-.4-2-1-2.7L52.7 25.6c-1-1-1.9-1.4-3-1.4z")
                                        .attribute(named: "fill", value: "#DBDBDC")
                                        .attribute(named: "fill-rule", value: "nonzero")
                                        .class("animated")
                                }
                                .attribute(named: "viewBox", value: "0 0 100 101")
                                .attribute(named: "version", value: "1.1")
                                .attribute(named: "xmlns", value: "http://www.w3.org/2000/svg")
                            }
                            .attribute(named: "title", value: "Send Mail")
                            .attribute(named: "type", value: "submit")
                            .class("submit")
                        }
                        .class("header")

                        Div {
                            Span("To:").class("label")
                            Text("Alexsander Akers")
                        }
                        .class("fieldset")

                        HorizontalRule()

                        Field(name: "subject", title: "Subject:", type: .text, placeholder: "What’s up?")
                        Field(name: "from", title: "From:", type: .text, placeholder: "Your Name")
                        Field(name: "email", title: "Reply To:", type: .email, placeholder: "Email Address")

                        Div()
                            .data(named: "netlify-recaptcha", value: "true")

                        Div {
                            TextArea(text: "", name: "message", numberOfRows: 0, numberOfColumns: nil, isRequired: true)
                                .attribute(named: "placeholder", value: "Tap here to type your message.")
                            Div("Sent from my iPhone 😉").class("signature")
                        }
                        .class("fieldset")
                    }
                    .attribute(named: "name", value: "contact")
                    .data(named: "netlify", value: "true")
                    .data(named: "netlify-recaptcha", value: "true")

                    Link(url: "#") { EmptyComponent() }
                        .attribute(named: "title", value: "Return to Homescreen")
                        .class("home-indicator")
                }
                .class("page foreground")
            }
        }
    }
}
