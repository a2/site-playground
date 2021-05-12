import Files
import Foundation
import Network
import Plot
import Publish

#if canImport(UserModule)
import UserModule
#endif

let fileManager = InMemoryFileManager()

try fileManager.createDirectory(atPath: "/Content", withIntermediateDirectories: true)
_ = fileManager.createFile(atPath: "/Content/index.md", contents: try Data(contentsOf: localFile(named: "index.md")))

let appsURL = localFile(named: "apps")
for child in try Foundation.FileManager.default.subpathsOfDirectory(atPath: appsURL.path) {
    _ = fileManager.createFile(atPath: "/Apps/\(child)", contents: try Data(contentsOf: appsURL.appendingPathComponent(child)))
}

try fileManager.createDirectory(atPath: "/Resources/images", withIntermediateDirectories: true)
_ = fileManager.createFile(atPath: "/Resources/images/background.jpg", contents: try! Data(contentsOf: localFile(named: "background.jpg")))

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
