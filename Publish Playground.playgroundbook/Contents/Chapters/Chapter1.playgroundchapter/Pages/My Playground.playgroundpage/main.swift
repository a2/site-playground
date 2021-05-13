import Files
import Foundation
import Network
import Plot
import Publish

#if canImport(UserModule)
import UserModule
#endif

let fileManager = InMemoryFileManager()
defaultFileManager = fileManager

try fileManager.createDirectory(atPath: "/Apps", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Content", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images/icons", withIntermediateDirectories: true)
try fileManager.createDirectory(atPath: "/Resources/images/screens", withIntermediateDirectories: true)

let contents: [LocalResource] = [
    #fileLiteral(resourceName: "index.md"), // index.md
]

let apps: [LocalResource] = [
    #fileLiteral(resourceName: "apps___babelgum.md"), // apps/babelgum.md
    #fileLiteral(resourceName: "apps___backgammon.md"), // apps/backgammon.md
    #fileLiteral(resourceName: "apps___bean.md"), // apps/bean.md
    #fileLiteral(resourceName: "apps___foursquare.md"), // apps/foursquare.md
    #fileLiteral(resourceName: "apps___outlook.md"), // apps/outlook.md
    #fileLiteral(resourceName: "apps___rooms.md"), // apps/rooms.md
    #fileLiteral(resourceName: "apps___shutterstock.md"), // apps/shutterstock.md
    #fileLiteral(resourceName: "apps___to-do.md"), // apps/to-do.md
]

let images: [LocalResource] = [
    #fileLiteral(resourceName: "images___background.jpg"), // images/background.jpg
    #fileLiteral(resourceName: "images___icons___babelgum.png"), // images/icons/babelgum.png
    #fileLiteral(resourceName: "images___icons___backgammon.png"), // images/icons/backgammon.png
    #fileLiteral(resourceName: "images___icons___bean.png"), // images/icons/bean.png
    #fileLiteral(resourceName: "images___icons___blank.png"), // images/icons/blank.png
    #fileLiteral(resourceName: "images___icons___contacts.png"), // images/icons/contacts.png
    #fileLiteral(resourceName: "images___icons___foursquare.png"), // images/icons/foursquare.png
    #fileLiteral(resourceName: "images___icons___mail.png"), // images/icons/mail.png
    #fileLiteral(resourceName: "images___icons___maps.png"), // images/icons/maps.png
    #fileLiteral(resourceName: "images___icons___messages.png"), // images/icons/messages.png
    #fileLiteral(resourceName: "images___icons___music.png"), // images/icons/music.png
    #fileLiteral(resourceName: "images___icons___outlook.png"), // images/icons/outlook.png
    #fileLiteral(resourceName: "images___icons___photos.png"), // images/icons/photos.png
    #fileLiteral(resourceName: "images___icons___rooms.png"), // images/icons/rooms.png
    #fileLiteral(resourceName: "images___icons___safari.png"), // images/icons/safari.png
    #fileLiteral(resourceName: "images___icons___shutterstock.png"), // images/icons/shutterstock.png
    #fileLiteral(resourceName: "images___icons___to-do.png"), // images/icons/to-do.png
    #fileLiteral(resourceName: "images___icons___twitter.png"), // images/icons/twitter.png
    #fileLiteral(resourceName: "images___screens___babelgum.jpg"), // images/screens/babelgum.jpg
    #fileLiteral(resourceName: "images___screens___backgammon.jpg"), // images/screens/backgammon.jpg
    #fileLiteral(resourceName: "images___screens___bean.jpg"), // images/screens/bean.jpg
    #fileLiteral(resourceName: "images___screens___foursquare.jpg"), // images/screens/foursquare.jpg
    #fileLiteral(resourceName: "images___screens___outlook.jpg"), // images/screens/outlook.jpg
    #fileLiteral(resourceName: "images___screens___rooms.jpg"), // images/screens/rooms.jpg
    #fileLiteral(resourceName: "images___screens___shutterstock.jpg"), // images/screens/shutterstock.jpg
    #fileLiteral(resourceName: "images___screens___to-do.jpg"), // images/screens/to-do.jpg
]

for resource in contents {
    _ = fileManager.createFile(atPath: "/Content/\(resource.lastPathComponent)", contentsOf: resource.fileURL)
}

for resource in apps {
    _ = fileManager.createFile(atPath: "/Apps/\(resource.lastPathComponent)", contentsOf: resource.fileURL)
}

for resource in images {
    _ = fileManager.createFile(atPath: "/Resources/\(resource.path)", contentsOf: resource.fileURL)
}

let publishedWebsite = try A2.Website()
    .publish(at: Path("/"), using: [
        .addMarkdownFiles(),
        .copyResources(at: "/Resources/images", to: "/images", includingFolder: true),
        .generateHTML(withTheme: A2.theme, indentation: .spaces(2)),
    ])

let outputPath = "/Output/"
let paths = try fileManager.subpathsOfDirectory(atPath: outputPath)
    .map { path in "- " + path[outputPath.endIndex.samePosition(in: path)!...]}
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
