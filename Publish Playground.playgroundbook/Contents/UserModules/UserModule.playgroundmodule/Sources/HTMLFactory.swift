import Foundation
import Plot
import Publish

extension A2 {
    public static var theme: Theme<Website> {
        Theme(htmlFactory: HTMLFactory(), resourcePaths: [], file: "HTMLFactory.swift")
    }

    private struct HTMLFactory: Publish.HTMLFactory {
        func makeStylesCSS(context: PublishingContext<Website>) throws -> String {
            let sass = """
@function unit($value) {
  @return 0.02rem * $value;
}

html,
body {
  height: 100%;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
  font-size: 16px;
  margin: 2.5rem;
}

a {
  color: #0A7AFF;
}

footer {
  margin-bottom: 2.5rem;
  text-align: center;
}

.target {
  left: 0;
  position: absolute;
  top: 0;
}

.content {
  display: flex;
  margin: 0 auto;
  width: 61rem;

  h1, h2 {
    margin: 0;
  }

  p {
    line-height: 1.5;
  }
}

.text-content {
  margin-left: 2.5rem;
  min-width: 32rem;
}

$transition-duration: 0.4s;
@media (prefers-reduced-motion) {
  .animated {
    transition: none !important;
  }
}

.phone {
  background: #233a4a;
  border-radius: unit(205);
  box-shadow: inset 0 0 unit(3) unit(2) rgba(0, 0, 0, 0.5), inset 0 0 unit(2) unit(5) #203747, inset 0 0 unit(2) unit(8) #ADCEE4, inset 0 unit(1) unit(4) unit(10) rgba(0, 0, 0, 0.35);
  flex-shrink: 0;
  font-size: unit(36);
  height: unit(2658);
  position: relative;
  width: unit(1296);

  &::before, &::after {
    border-radius: unit(183);
    content: "";
  }

  &::before {
    background: #2e2c2a;
    box-shadow: unit(-6) 0 unit(3) 0 rgba(255, 255, 255, 0.08), 0 0 unit(2) unit(1) rgba(0, 0, 0, 0.6), inset 0 0 unit(1) unit(1) rgba(0, 0, 0, 0.5);
    height: calc(100% - #{unit(36)});
    position: absolute;
    top: unit(18);
    left: unit(18);
    width: calc(100% - #{unit(36)});
  }

  &::after {
    background: #000;
    height: calc(100% - #{unit(42)});
    top: unit(21);
    left: unit(21);
    position: absolute;
    width: calc(100% - #{unit(42)});
  }

  .buttons {
    * {
      border-radius: unit(2);
      box-shadow: inset unit(-10) 0 unit(3) 0 rgba(0, 0, 0, 0.4), inset unit(2) 0 unit(1) 0 rgba(0, 0, 0, 0.6), inset 0 unit(3) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(-3) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(6) unit(1) 0 #BDE1F7, inset 0 unit(-6) unit(1) 0 #BDE1F7, inset unit(4) 0 unit(1) 0 #BDE1F7;
      position: absolute;
      width: unit(17);
      z-index: -1;
    }

    .power {
      background: linear-gradient(0deg, #0B212B 3%, #668091 8%, #668192 93%, #11232E 98%);
      border-radius: unit(4);
      box-shadow: inset unit(-10) 0 unit(3) 0 rgba(0, 0, 0, 0.4), inset unit(2) 0 unit(1) 0 rgba(0, 0, 0, 0.6), inset 0 unit(3) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(-3) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(6) unit(1) 0 #BDE1F7, inset 0 unit(-6) unit(1) 0 #BDE1F7, inset unit(4) 0 unit(1) 0 #BDE1F7;
      height: unit(316);
      right: unit(-8.5);
      top: unit(681);
    }

    .mute {
      background: linear-gradient(0deg, #0B212B 5%, #668091 14%, #668192 86%, #11232E 96%);
      box-shadow: inset unit(-9) 0 unit(3) 0 rgba(0, 0, 0, 0.5), inset unit(1) 0 unit(1) 0 rgba(0, 0, 0, 0.6), inset 0 unit(2) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(-2) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(4) unit(1) 0 #BDE1F7, inset 0 unit(-4) unit(1) 0 #BDE1F7, inset unit(3) 0 unit(1) 0 rgba(189,225,247, 0.75);
      height: unit(100);
      left: unit(-8.5);
      top: unit(422);
    }

    .volume-up,
    .volume-down {
      background: linear-gradient(0deg, #0B212B 5%, #668091 10%, #668192 90%, #11232E 96%);
      box-shadow: inset unit(-11) 0 unit(3) 0 rgba(0, 0, 0, 0.5), inset unit(1) 0 unit(1) 0 rgba(0, 0, 0, 0.6), inset 0 unit(2) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(-2) unit(2) 0 rgba(0, 0, 0, 0.85), inset 0 unit(4) unit(1) 0 #BDE1F7, inset 0 unit(-4) unit(1) 0 #BDE1F7, inset unit(3) 0 unit(1) 0 rgba(189, 225, 247, 0.75);
      height: unit(200);
      left: unit(-8.5);
    }

    .volume-up {
      top: unit(613);
    }

    .volume-down {
      top: unit(867);
    }
  }

  .bands {
    * {
      opacity: 0.8;
      width: unit(19);
      height: unit(18);
      position: absolute;
    }

    .right {
      right: 0;
    }

    .left {
      left: 0;
    }

    .bottom.left,
    .bottom.right {
      bottom: unit(269);
    }

    .bottom.right {
      background: #3C494F;
    }

    .bottom.center {
      background: #39464E;
      width: unit(18);
      height: unit(19);
      left: unit(262);
      bottom: 0;
    }

    .bottom.left {
      background: #3C464F;
      width: unit(19);
      height: unit(17);
    }

    .top.left,
    .top.right {
      top: unit(269);
    }

    .top.center {
      background: #59656F;
      top: 0;
      right: unit(259);
    }

    .top.left {
      background: #56646C;
    }

    .top.right {
      background: #57646C;
    }
  }

  .display {
    border-radius: unit(142);
    width: unit(1170);
    height: unit(2532);
    position: absolute;
    top: unit(63);
    left: unit(63);
    background: black;
    z-index: 1;
    overflow: hidden;

    .notch {
      background-color: #000;
      border-radius: 0 0 unit(66) unit(66);
      content: "";
      height: unit(95.5);
      left: 50%;
      transform: translateX(-50%);
      position: absolute;
      top: 0;
      width: unit(632);
      z-index: 2;

      &::before,
      &::after {
        background-image: radial-gradient(circle at 0 100%, transparent unit(18), #000 unit(18));
        background-repeat: no-repeat;
        background-size: 50% 100%;
        content: "";
        height: unit(18);
        left: unit(-18);
        position: absolute;
        top: 0;
        width: unit(36);
      }

      &::after {
        background-image: radial-gradient(circle at 100% 100%, transparent unit(18), #000 unit(18));
        left: 100%;
      }
    }

    .homescreen {
      color: #fff;
      display: flex;
      flex-direction: column;
      height: 100%;
      transition: $transition-duration filter;
      width: 100%;

      :target ~ & {
        filter: blur(30px) brightness(0.5);
      }

      .background {
        border-radius: unit(142);
        background: url("/images/background.jpg") center/115% no-repeat;
        height: 100%;
        left: 0;
        position: absolute;
        top: 0;
        width: 100%;
      }

      .icons {
        flex: 1;
        margin-top: unit(231);
        transition-duration: $transition-duration;
        transition-property: transform, opacity;
        width: 100%;

        :target ~ & {
          transform: scale(0.8);
          opacity: 0.8;
        }
      }
    }
  }

  .status-bar {
    color: #fff;
    display: flex;
    flex-direction: row;
    font-size: unit(48);
    font-weight: 500;
    height: unit(144);
    justify-content: space-between;
    position: absolute;
    transition: $transition-duration color;
    width: 100%;
    z-index: 2;

    > * {
      align-self: center;
      text-align: center;
      width: unit(312);
    }

    .status {
      height: unit(36);
    }

    .path-fill {
      transition: $transition-duration fill;
    }

    .path-stroke {
      transition: $transition-duration stroke;
    }
  }

  .icons ul {
    column-gap: unit(30);
    margin: 0 unit(60);
    row-gap: unit(54);

    li {
      width: unit(240);

      a {
        color: #fff;
        text-decoration: none;
        text-overflow: clip;
      }
    }
  }

  .icons ul,
  .dock ul {
    list-style: none;
    padding-left: 0;
    display: grid;
    grid-template-columns: repeat(4, 1fr);

    li {
      overflow: hidden;
      padding-top: unit(192);
      position: relative;
      text-align: center;
      text-overflow: ellipsis;
    }
  }

  .dock {
    -webkit-backdrop-filter: blur(30px) saturate(110%);
    backdrop-filter: blur(30px) saturate(110%);
    background: rgba(255, 255, 255, 0.3);
    border-radius: unit(93);
    height: unit(287);
    margin: unit(36);

    .app::before {
      left: 0;
    }

    ul {
      column-gap: unit(90);
      margin: unit(51) unit(42);

      li {
        font-size: unit(0);
        width: unit(180);
      }
    }
  }

  .screen {
    background-size: cover;
    border-radius: unit(141);
    height: 100%;
    left: 0;
    opacity: 0;
    position: absolute;
    text-indent: -9999rem;
    top: 0;
    transform: scale(0.1);
    transition-duration: $transition-duration;
    transition-property: opacity, transform, z-index;
    width: 100%;
    z-index: -1;
  }

  .app::before {
    $mask: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" stroke-linejoin="round" stroke-miterlimit="1.4" clip-rule="evenodd" viewBox="0 0 460 460"%3E%3Cpath d="M460 316v30a202 202 0 01-3 31c-2 10-5 19-9 28a97 97 0 01-43 43 102 102 0 01-28 9c-10 2-20 3-31 3a649 649 0 01-13 0H127a649 649 0 01-13 0 201 201 0 01-31-3c-10-2-19-5-28-9a97 97 0 01-43-43 102 102 0 01-9-28 202 202 0 01-3-31v-13-189-17-13a202 202 0 013-31c2-10 5-19 9-28a97 97 0 0143-43 102 102 0 0128-9 203 203 0 0144-3h206a649 649 0 0113 0c11 0 21 1 31 3s19 5 28 9a97 97 0 0143 43 102 102 0 019 28 202 202 0 013 31 643 643 0 010 30v172z"/%3E%3C/svg%3E');
    -webkit-mask: $mask center/100% 100% no-repeat;
    background: url("/images/icons/blank.png") center/cover;
    content: "";
    height: unit(180);
    left: unit(30);
    mask: $mask center/100% 100% no-repeat;
    position: absolute;
    top: 0;
    width: unit(180);
  }
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
  background-image: url("/images/icons/\(app.id).png");
}

.phone .screen-\(app.id) {
  background-image: url("/images/screens/\(app.id).jpg");
}
""" }.joined(separator: "\n\n"))

\(context.site.dock.map { app in """
.phone .app-\(app.id)::before {
  background-image: url("/images/icons/\(app.id).png");
}
""" }.joined(separator: "\n\n"))

\(context.site.homescreen.map { app in ".content-\(app.id), #\(app.id):target ~ .text-content .content-default" }.joined(separator: ", ")) {
  display: none;
}

\(context.site.homescreen.map { app in "#\(app.id):target ~ .text-content .content-\(app.id)" }.joined(separator: ", ")) {
  display: unset;
}

\(context.site.homescreen.map { app in "#\(app.id):target ~ .phone .screen-\(app.id)" }.joined(separator: ", ")) {
  opacity: unset;
  transform: unset;
  z-index: 1; // bug in Chrome: use `1` not `unset`
}
"""

            let archiveResource: LocalResource = #fileLiteral(resourceName: "sass.js.aar") // sass.js.aar
            return try Sass(compressedScriptURL: archiveResource.fileURL)!
                .compileSync(styles: sass, options: Sass.Options(outputStyle: .compressed))
        }

        func makeIndexHTML(for index: Index, context: PublishingContext<Website>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index, on: context.site, inlineStyles: [try makeStylesCSS(context: context)]),
                .body {
                    // SiteHeader(context: context, selectedSelectionID: nil)

                    ContentWrapper {
                        ComponentGroup(members: context.site.homescreen.map { app in
                            Div()
                                .class("target")
                                .id(app.id)
                        })

                        Phone(homescreen: context.site.homescreen, dock: context.site.dock)

                        Div {
                            H1(context.site.name)

                            Div(index.body)
                                .class("content-default")

                            ComponentGroup(members: context.site.homescreen.compactMap { app in
                                let file = try! context.file(at: app.markdownPath)
                                let contents = try! file.readAsString()

                                return Div {
                                    H2(app.title ?? app.name)
                                    Markdown(contents)
                                    Link("← Back", url: "#")
                                }
                                .class("content-\(app.id)")
                            })

                            SiteFooter()
                        }
                        .class("text-content")
                    }
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
            nil
        }

        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Website>) throws -> HTML? {
            nil
        }
    }
}

extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        inlineStyles: [String] = [],
        stylesheetPaths: [Path] = []
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
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .forEach(inlineStyles, { .style($0) })
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
                return Link(section.title, url: section.path.absoluteString)
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
    @ComponentBuilder var body: Component {
        Footer {
            let link = Link("Publish", url: "https://github.com/JohnSundell/Publish")
                .linkTarget(.blank)
            Paragraph(html: "Generated using \(link.render())")
        }
    }
}
