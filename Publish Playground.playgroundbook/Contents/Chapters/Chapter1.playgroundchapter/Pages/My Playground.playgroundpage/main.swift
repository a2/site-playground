import Files
import Foundation
import Network
import Plot
import Publish

#if canImport(UserModule)
import UserModule
#endif

let fileManager = InMemoryFileManager()

try fileManager.createDirectory(atPath: "/Apps", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Content", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images/icons", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images/screens", withIntermediateDirectories: true)

let contents = ["index.md"]
for child in contents {
    _ = fileManager.createFile(atPath: "/Content/\(child)", contentsOf: localFile(named: child))
}

let apps = """
apps/babelgum.md
apps/backgammon.md
apps/bean.md
apps/foursquare.md
apps/outlook.md
apps/rooms.md
apps/shutterstock.md
apps/to-do.md
"""

for child in apps.components(separatedBy: .newlines) {
    _ = fileManager.createFile(atPath: "/Apps/\((child as NSString).lastPathComponent)", contentsOf: localFile(named: child))
}

let images = """
images/background.jpg
images/icons/babelgum.png
images/icons/backgammon.png
images/icons/bean.png
images/icons/blank.png
images/icons/contacts.png
images/icons/foursquare.png
images/icons/mail.png
images/icons/maps.png
images/icons/messages.png
images/icons/music.png
images/icons/outlook.png
images/icons/photos.png
images/icons/rooms.png
images/icons/safari.png
images/icons/shutterstock.png
images/icons/to-do.png
images/icons/twitter.png
images/screens/babelgum.jpg
images/screens/backgammon.jpg
images/screens/bean.jpg
images/screens/foursquare.jpg
images/screens/outlook.jpg
images/screens/rooms.jpg
images/screens/shutterstock.jpg
images/screens/to-do.jpg
"""

for child in images.components(separatedBy: .newlines) {
    _ = fileManager.createFile(atPath: "/Resources/\(child)", contentsOf: localFile(named: child))
}

let indentation: Indentation.Kind = .spaces(2)
let publishedWebsite = try fileManager.performAsDefault {
    try A2.Website().publish(at: Path("/"), using: [
        .addMarkdownFiles(),
        .copyResources(at: "/Resources/images", to: "/images", includingFolder: true),
        .generateHTML(withTheme: A2.theme, indentation: indentation),
        .generateRSSFeed(including: Set(A2.Website.SectionID.allCases), config: .init(indentation: indentation)),
        .generateSiteMap(indentedBy: indentation),
    ])
}

let outputPath = "/Output"
let paths = try fileManager.subpathsOfDirectory(atPath: outputPath)
    .map { path in "- " + path[String.Index(outputPath.endIndex, within: outputPath)!...]}
    .sorted()
    .joined(separator: "\n")

print()
print("Generated files:", paths, separator: "\n")
print()

let server = Server(fileManager: fileManager)
try server.start(port: 8000)

#if canImport(PlaygroundSupport)
import PlaygroundSupport
import WebKit

let webView = WKWebView()
webView.load(URLRequest(url: URL(string: "http://localhost:8000")!))

let page = PlaygroundPage.current
page.wantsFullScreenLiveView = true
page.liveView = webView
#else
RunLoop.current.run()
#endif
