import Files
import Foundation
import Plot
import Publish

#if canImport(Network)
import Network
#endif

#if canImport(UserModule)
import UserModule
#endif

let fileManager = InMemoryFileManager()
Files.defaultFileManager = fileManager

for resource in LocalResource.all {
    let resourceURL = resource.fileURL

    let sourcePath = resourceURL.path
    let destinationPath = resourceURL.lastPathComponent.replacingOccurrences(of: "___", with: "/")

    let destinationDirectory = destinationPath.lastIndex(of: "/").map { index in String(destinationPath[...index]) } ?? destinationPath
    try fileManager.createDirectory(atPath: destinationDirectory, withIntermediateDirectories: true)

    try Foundation.FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath, in: fileManager)
}

let publishedWebsite = try A2.Website()
    .publish(at: Path("/"), using: [
        .addMarkdownFiles(at: "/Content"),
        .copyResources(at: "/Resources/images", to: "/images", includingFolder: true),
        .generateHTML(withTheme: A2.theme, indentation: .spaces(2)),
    ])

let outputFileManager = InMemoryFileManager(fileManager: fileManager, relativePath: "Output")
if CommandLine.isVerbose {
    let paths = try outputFileManager.subpathsOfDirectory(atPath: ".")
        .map { path in "- " + path[outputFileManager.currentDirectoryPath.endIndex.samePosition(in: path)!...] }
        .sorted()
        .joined(separator: "\n")

    print()
    print("Generated files:", paths, separator: "\n")
    print()
}

#if canImport(Network)
let runningServer: Server? = try {
    guard CommandLine.shouldServe else { return nil }
    let server = Server(fileManager: outputFileManager)
    try server.start(port: CommandLine.port)
    return server
}()
#endif

#if canImport(PlaygroundSupport)
import PlaygroundSupport
import WebKit

let webView = WKWebView()
webView.load(URLRequest(url: URL(string: "http://localhost:\(CommandLine.port)")!))

let page = PlaygroundPage.current
page.wantsFullScreenLiveView = true
page.liveView = webView
#else
#if canImport(AppKit)
import AppKit

if CommandLine.shouldOpenBrowser {
    NSWorkspace.shared.open(URL(string: "http://localhost:\(CommandLine.port)")!)
}
#endif

if let exportPath = CommandLine.exportPath {
    try outputFileManager.copyItem(atPath: "/", toPath: exportPath, in: Foundation.FileManager.default)
}

#if canImport(Network)
if runningServer != nil {
    RunLoop.main.run()
}
#endif
#endif
