import Plot

struct HorizontalRule: Component {
    var body: Component {
        Element<Any>.selfClosed(named: "hr", attributes: [])
    }
}
