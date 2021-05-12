import Foundation
import Plot
import Publish

extension A2 {
    static var theme: Theme<Website> {
        Theme(htmlFactory: HTMLFactory(), resourcePaths: [], file: "HTMLFactory.swift")
    }

    private struct HTMLFactory: Publish.HTMLFactory {
        func makeStylesCSS(context: PublishingContext<Website>) throws -> String {
            func format(_ value: Decimal) -> String { value.isZero ? "0" : "\(value * 0.02)rem" }
            return """
html,
body {
    padding: 0;
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
    font-size: 16px;
    height: 100%;
}

.content {
    display: flex;
}

.content h1, .content h2 {
    margin: 0;
}

.content p {
    line-height: 1.5;
}

@media (prefers-reduced-motion) {
    .animated {
        transition: none !important;
    }
}

.phone {
    background: #233a4a;
    border-radius: \(format(205));
    box-shadow: inset 0 0 \(format(3)) \(format(2)) rgba(0, 0, 0, 0.5), inset 0 0 \(format(2)) \(format(5)) #203747, inset 0 0 \(format(2)) \(format(8)) #ADCEE4, inset 0 \(format(1)) \(format(4)) \(format(10)) rgba(0, 0, 0, 0.35);
    flex-shrink: 0;
    font-size: \(format(36));
    height: \(format(2658));
    position: relative;
    width: \(format(1296));
    margin: \(format(120));
}

.phone::before, .phone::after {
    border-radius: \(format(183));
    content: "";
}

.phone::before {
    background: #2e2c2a;
    box-shadow: \(format(-6)) 0 \(format(3)) 0 rgba(255, 255, 255, 0.08), 0 0 \(format(2)) \(format(1)) rgba(0, 0, 0, 0.6), inset 0 0 \(format(1)) \(format(1)) rgba(0, 0, 0, 0.5);
    height: calc(100% - \(format(36)));
    position: absolute;
    top: \(format(18));
    left: \(format(18));
    width: calc(100% - \(format(36)));
}

.phone::after {
    background: #000;
    height: calc(100% - \(format(42)));
    top: \(format(21));
    left: \(format(21));
    position: absolute;
    width: calc(100% - \(format(42)));
}

.phone .buttons * {
    border-radius: \(format(2));
    box-shadow: inset \(format(-10)) 0 \(format(3)) 0 rgba(0, 0, 0, 0.4), inset \(format(2)) 0 \(format(1)) 0 rgba(0, 0, 0, 0.6), inset 0 \(format(3)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(-3)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(6)) \(format(1)) 0 #BDE1F7, inset 0 \(format(-6)) \(format(1)) 0 #BDE1F7, inset \(format(4)) 0 \(format(1)) 0 #BDE1F7;
    position: absolute;
    width: \(format(17));
    z-index: -1;
}

.phone .buttons .power {
    background: linear-gradient(0deg, #0B212B 3%, #668091 8%, #668192 93%, #11232E 98%);
    border-radius: \(format(4));
    box-shadow: inset \(format(-10)) 0 \(format(3)) 0 rgba(0, 0, 0, 0.4), inset \(format(2)) 0 \(format(1)) 0 rgba(0, 0, 0, 0.6), inset 0 \(format(3)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(-3)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(6)) \(format(1)) 0 #BDE1F7, inset 0 \(format(-6)) \(format(1)) 0 #BDE1F7, inset \(format(4)) 0 \(format(1)) 0 #BDE1F7;
    height: \(format(316));
    right: \(format(-8.5));
    top: \(format(681));
}

.phone .buttons .mute {
    background: linear-gradient(0deg, #0B212B 5%, #668091 14%, #668192 86%, #11232E 96%);
    box-shadow: inset \(format(-9)) 0 \(format(3)) 0 rgba(0, 0, 0, 0.5), inset \(format(1)) 0 \(format(1)) 0 rgba(0, 0, 0, 0.6), inset 0 \(format(2)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(-2)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(4)) \(format(1)) 0 #BDE1F7, inset 0 \(format(-4)) \(format(1)) 0 #BDE1F7, inset \(format(3)) 0 \(format(1)) 0 rgba(189,225,247, 0.75);
    height: \(format(100));
    left: \(format(-8.5));
    top: \(format(422));
}

.phone .buttons .volume-up, .phone .buttons .volume-down {
    background: linear-gradient(0deg, #0B212B 5%, #668091 10%, #668192 90%, #11232E 96%);
    box-shadow: inset \(format(-11)) 0 \(format(3)) 0 rgba(0, 0, 0, 0.5), inset \(format(1)) 0 \(format(1)) 0 rgba(0, 0, 0, 0.6), inset 0 \(format(2)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(-2)) \(format(2)) 0 rgba(0, 0, 0, 0.85), inset 0 \(format(4)) \(format(1)) 0 #BDE1F7, inset 0 \(format(-4)) \(format(1)) 0 #BDE1F7, inset \(format(3)) 0 \(format(1)) 0 rgba(189, 225, 247, 0.75);
    height: \(format(200));
    left: \(format(-8.5));
}

.phone .buttons .volume-up {
    top: \(format(613));
}

.phone .buttons .volume-down {
    top: \(format(867));
}

.phone .bands * {
    opacity: 0.8;
    width: \(format(19));
    height: \(format(18));
    position: absolute;
}

.phone .bands .right {
    right: 0;
}

.phone .bands .left {
    left: 0;
}

.phone .bands .bottom.left,
.phone .bands .bottom.right {
    bottom: \(format(269));
}

.phone .bands .bottom.right {
    background: #3C494F;
}

.phone .bands .bottom.center {
    background: #39464E;
    width: \(format(18));
    height: \(format(19));
    left: \(format(262));
    bottom: 0;
}

.phone .bands .bottom.left {
    background: #3C464F;
    width: \(format(19));
    height: \(format(17));
}

.phone .bands .top.left,
.phone .bands .top.right {
    top: \(format(269));
}

.phone .bands .top.center {
    background: #59656F;
    top: 0;
    right: \(format(259));
}

.phone .bands .top.left {
    background: #56646C;
}

.phone .bands .top.right {
    background: #57646C;
}

.phone .display {
    border-radius: \(format(142));
    width: \(format(1170));
    height: \(format(2532));
    position: absolute;
    top: \(format(63));
    left: \(format(63));
    background: black;
    z-index: 1;
    overflow: hidden;
}

.phone .display .notch {
    background-color: #000;
    border-radius: 0 0 \(format(66)) \(format(66));
    content: "";
    height: \(format(95.5));
    left: 50%;
    transform: translateX(-50%);
    position: absolute;
    top: 0;
    width: \(format(632));
    z-index: 2;
}

.phone .display .notch::before,
.phone .display .notch::after {
    background-image: radial-gradient(circle at 0 100%, transparent \(format(18)), #000 \(format(18)));
    background-repeat: no-repeat;
    background-size: 50% 100%;
    content: "";
    height: \(format(18));
    left: \(format(-18));
    position: absolute;
    top: 0;
    width: \(format(36));
}

.phone .display .notch::after {
    background-image: radial-gradient(circle at 100% 100%, transparent \(format(18)), #000 \(format(18)));
    left: 100%;
}

.phone .display .homescreen {
    color: #fff;
    display: flex;
    flex-direction: column;
    height: 100%;
    transition: 0.4s filter;
    width: 100%;
}

:target ~ .phone .display .homescreen {
    filter: blur(30px) brightness(0.5);
}

.phone .display .homescreen .background {
    border-radius: \(format(142));
    background: url("/images/background.jpg") center/115% no-repeat;
    height: 100%;
    left: 0;
    position: absolute;
    top: 0;
    width: 100%;
}

.phone .display .homescreen .icons {
    flex: 1;
    margin-top: \(format(231));
    transition-duration: 0.4s;
    transition-property: transform, opacity;
    width: 100%;

}

:target ~ .phone .display .homescreen .icons {
    transform: scale(0.8);
    opacity: 0.8;
}

.phone .status-bar {
    color: #fff;
    display: flex;
    flex-direction: row;
    font-size: \(format(48));
    font-weight: 500;
    height: \(format(144));
    justify-content: space-between;
    position: absolute;
    transition: 0.4s color;
    width: 100%;
    z-index: 2;
}

.phone .status-bar > * {
    align-self: center;
    text-align: center;
    width: \(format(312));
}

.phone .status-bar .status {
    height: \(format(36));
}

.phone .status-bar .path-fill {
    transition: 0.4s fill;
}

.phone .status-bar .path-stroke {
    transition: 0.4s stroke;
}

.phone .icons ul {
    column-gap: \(format(30));
    margin: 0 \(format(60));
    row-gap: \(format(54));
}

.phone .icons ul li {
    width: \(format(240));
}

.phone .icons ul li a {
    color: #fff;
    text-decoration: none;
    text-overflow: clip;
}

.phone .icons ul, .phone .dock ul {
    list-style: none;
    padding-left: 0;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
}

.phone .icons ul li, .phone .dock ul li {
    overflow: hidden;
    padding-top: \(format(192));
    position: relative;
    text-align: center;
    text-overflow: ellipsis;
}

.phone .dock {
    -webkit-backdrop-filter: blur(30px) saturate(110%);
    backdrop-filter: blur(30px) saturate(110%);
    background: rgba(255, 255, 255, 0.3);
    border-radius: \(format(93));
    height: \(format(287));
    margin: \(format(36));
}

.phone .dock .app::before {
    left: 0;
}

.phone .dock ul {
    column-gap: \(format(90));
    margin: \(format(51)) \(format(42));
}

.phone .dock ul li {
    font-size: \(format(0));
    width: \(format(180));
}

.phone .screen {
    background-size: cover;
    border-radius: \(format(141));
    height: 100%;
    left: 0;
    opacity: 0;
    position: absolute;
    text-indent: -9999rem;
    top: 0;
    transform: scale(0.1);
    transition-duration: 0.4s;
    transition-property: opacity, transform, z-index;
    width: 100%;
    z-index: -1;
}

.phone .screen .app::before {
    -webkit-mask: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" stroke-linejoin="round" stroke-miterlimit="1.4" clip-rule="evenodd" viewBox="0 0 460 460"%3E%3Cpath d="M460 316v30a202 202 0 01-3 31c-2 10-5 19-9 28a97 97 0 01-43 43 102 102 0 01-28 9c-10 2-20 3-31 3a649 649 0 01-13 0H127a649 649 0 01-13 0 201 201 0 01-31-3c-10-2-19-5-28-9a97 97 0 01-43-43 102 102 0 01-9-28 202 202 0 01-3-31v-13-189-17-13a202 202 0 013-31c2-10 5-19 9-28a97 97 0 0143-43 102 102 0 0128-9 203 203 0 0144-3h206a649 649 0 0113 0c11 0 21 1 31 3s19 5 28 9a97 97 0 0143 43 102 102 0 019 28 202 202 0 013 31 643 643 0 010 30v172z"/%3E%3C/svg%3E') center/100% 100% no-repeat;
    background: url("/images/icons/blank.png") center/cover;
    content: "";
    height: \(format(180));
    left: \(format(30));
    mask: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" stroke-linejoin="round" stroke-miterlimit="1.4" clip-rule="evenodd" viewBox="0 0 460 460"%3E%3Cpath d="M460 316v30a202 202 0 01-3 31c-2 10-5 19-9 28a97 97 0 01-43 43 102 102 0 01-28 9c-10 2-20 3-31 3a649 649 0 01-13 0H127a649 649 0 01-13 0 201 201 0 01-31-3c-10-2-19-5-28-9a97 97 0 01-43-43 102 102 0 01-9-28 202 202 0 01-3-31v-13-189-17-13a202 202 0 013-31c2-10 5-19 9-28a97 97 0 0143-43 102 102 0 0128-9 203 203 0 0144-3h206a649 649 0 0113 0c11 0 21 1 31 3s19 5 28 9a97 97 0 0143 43 102 102 0 019 28 202 202 0 013 31 643 643 0 010 30v172z"/%3E%3C/svg%3E') center/100% 100% no-repeat;
    position: absolute;
    top: 0;
    width: \(format(180));
}

.text-content {
    padding-top: \(format(120));
    padding-right: \(format(120));
    min-width: \(format(1500));
}

\(context.site.homescreen.filter { $0.hasInvertedStatusBar }.map { app in "#\(app.id):target ~ .phone .status-bar" }.joined(separator: ",\n")) {
    color: #000;
}

\(context.site.homescreen.filter { $0.hasInvertedStatusBar }.map { app in "#\(app.id):target ~ .phone .status-bar .path-fill" }.joined(separator: ",\n")) {
    fill: #000;
}

\(context.site.homescreen.filter { $0.hasInvertedStatusBar }.map { app in "#\(app.id):target ~ .phone .status-bar .path-stroke" }.joined(separator: ",\n")) {
    stroke: #000;
}

\(context.site.homescreen.map { app in """
.phone .app-\(app.id)::before {
    background-image: url("/images/icons/\(app.id).png";
}

.phone .screen-\(app.id) {
    background-image: url("/images/screens/\(app.id).jpg";
}
""" }.joined(separator: "\n\n"))

\(context.site.dock.map { app in """
.phone .app-\(app.id)::before {
    background-image: url("/images/icons/\(app.id).png";
}
""" }.joined(separator: "\n\n"))

\(context.site.homescreen.map { app in ".content-\(app.id), #\(app.id):target ~ .text-content .content-default" }.joined(separator: ", ")) {
    display: none;
}

\(context.site.homescreen.map { app in "#\(app.id):target ~ .text-content .content-\(app.id)" }.joined(separator: ", ")) {
    display: unset;
}

\(context.site.homescreen.map { app in "#\(app.id):target ~ .phone .screen-\(app.id)" }.joined(separator: ", ")) {
    z-index: 1; // bug in Chrome: use `1` not `unset`
    opacity: unset;
    transform: unset;
}

"""
        }

        func makeIndexHTML(for index: Index, context: PublishingContext<Website>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index, on: context.site, inlineStyles: [try makeStylesCSS(context: context)]),
                .body {
                    // SiteHeader(context: context, selectedSelectionID: nil)

                    ContentWrapper {
                        ComponentGroup(members: context.site.homescreen.map { app in
                            Div().id(app.id)
                        })

                        Phone(homescreen: context.site.homescreen, dock: context.site.dock)

                        Div {
                            H1(context.site.name)

                            Div {
                                H2(context.site.subtitle)
                                index.body
                            }
                            .class("content-default")

                            ComponentGroup(members: context.site.homescreen.compactMap { app in
                                guard let page = context.pages[Path(app.id)] else { return nil }

                                return Div {
                                    H2(app.title ?? app.name)
                                    page.body
                                    Link("&larr; Back", url: "#")

                                }
                                .class("content-\(app.id)")
                            })
                        }
                        .class("text-content")

                        /*
                         H1(index.title)
                         Paragraph(context.site.description)
                         .class("description")
                         H2("Latest content")
                         ItemList(
                         items: context.allItems(
                         sortedBy: \.date,
                         order: .descending
                         ),
                         site: context.site
                         )
                         */
                    }

                    SiteFooter()
                }
            )
        }

        func makeSectionHTML(for section: Section<Website>, context: PublishingContext<Website>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site, stylesheetPaths: []),
                .body {
                    SiteHeader(context: context, selectedSelectionID: section.id)
                    ContentWrapper {
                        H1(section.title)
                        ItemList(items: section.items, site: context.site)
                    }
                    SiteFooter()
                }
            )
        }

        func makeItemHTML(for item: Item<Website>, context: PublishingContext<Website>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: item, on: context.site, stylesheetPaths: []),
                .body(
                    .class("item-page"),
                    .components {
                        SiteHeader(context: context, selectedSelectionID: item.sectionID)
                        ContentWrapper {
                            Article {
                                Div(item.content.body).class("content")
                                Span("Tagged with: ")
                                ItemTagList(item: item, site: context.site)
                            }
                        }
                        SiteFooter()
                    }
                )
            )
        }

        func makePageHTML(for page: Page, context: PublishingContext<Website>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site, stylesheetPaths: []),
                .body {
                    SiteHeader(context: context, selectedSelectionID: nil)
                    ContentWrapper(page.body)
                    SiteFooter()
                }
            )
        }

        func makeTagListHTML(for page: TagListPage, context: PublishingContext<Website>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site, stylesheetPaths: []),
                .body {
                    SiteHeader(context: context, selectedSelectionID: nil)
                    ContentWrapper {
                        H1("Browse all tags")
                        List(page.tags.sorted()) { tag in
                            ListItem {
                                Link(tag.string,
                                     url: context.site.path(for: tag).absoluteString
                                )
                            }
                            .class("tag")
                        }
                        .class("all-tags")
                    }
                    SiteFooter()
                }
            )
        }

        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Website>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site, stylesheetPaths: []),
                .body {
                    SiteHeader(context: context, selectedSelectionID: nil)
                    ContentWrapper {
                        H1 {
                            Text("Tagged with ")
                            Span(page.tag.string).class("tag")
                        }

                        Link("Browse all tags",
                             url: context.site.tagListPath.absoluteString
                        )
                        .class("browse-all")

                        ItemList(
                            items: context.items(
                                taggedWith: page.tag,
                                sortedBy: \.date,
                                order: .descending
                            ),
                            site: context.site
                        )
                    }
                    SiteFooter()
                }
            )
        }
    }
}

extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        inlineStyles: [String] = [],
        stylesheetPaths: [Path] = [],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .forEach(inlineStyles, { styles in .style(styles) })
        )
    }
}

private struct ContentWrapper: ComponentContainer {
    var content: ContentProvider

    init(@ComponentBuilder content: @escaping ContentProvider) {
        self.content = content
    }

    @ComponentBuilder var body: Component {
        Div(content: content)
            .class("content")
    }
}

private struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?

    @ComponentBuilder var body: Component {
        Header {
            ContentWrapper {
                Link(context.site.name, url: "/")
                    .class("site-name")

                if Site.SectionID.allCases.count > 1 {
                    navigation
                }
            }
        }
    }

    @ComponentBuilder private var navigation: Component {
        Navigation {
            List(Site.SectionID.allCases) { sectionID in
                let section = context.sections[sectionID]

                return Link(section.title,
                            url: section.path.absoluteString
                )
                .class(sectionID == selectedSelectionID ? "selected" : "")
            }
        }
    }
}

private struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site

    @ComponentBuilder var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                Paragraph(item.description)
            }
        }
        .class("item-list")
    }
}

private struct ItemTagList<Site: Website>: Component {
    var item: Item<Site>
    var site: Site

    @ComponentBuilder var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
        .class("tag-list")
    }
}

private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Generated using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
