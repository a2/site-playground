import Foundation
import Plot
import Publish

struct HorizontalRule: Component {
    var body: Component {
        Element<Any>.selfClosed(named: "hr", attributes: [])
    }
}

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
    public var title: String? { nil }
    public var location: AppLocation { .dock }

    public init() {}

    public var screen: Screen {
        Screen(hasInvertedStatusBar: false) {
            Div {
                Div().class("page background")
                Div {
                    Link("Cancel", url: "#").class("cancel")

                    Form(url: "/", method: .post) {
                        Header {
                            Span("New Message")
                                .class("title")

                            SubmitButton("")
                                .attribute(named: "title", value: "Send Mail")
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

                        Div {
                            TextArea(text: "", name: "message", numberOfRows: 0, numberOfColumns: nil, isRequired: true)
                                .attribute(named: "placeholder", value: "Tap here and type your message.")
                            Div("Sent from my iPhone 😉").class("signature")
                        }
                        .class("fieldset")
                    }
                }
                .class("page foreground")
            }
        }
    }
}
