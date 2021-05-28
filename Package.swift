// swift-tools-version:5.3
import PackageDescription

let page = "Publish Playground.playgroundbook/Contents/Chapters/Chapter1.playgroundchapter/Pages"
let userModules = "Publish Playground.playgroundbook/Contents/UserModules"

func excludes(for target: String? = nil) -> [String] {
    var targets = ["Codextended.playgroundmodule", "Files.playgroundmodule", "Ink.playgroundmodule", "Plot.playgroundmodule", "Publish.playgroundmodule", "Sweep.playgroundmodule", "UserModule.playgroundmodule"]
    if let target = target, let index = targets.firstIndex(of: target) {
        targets.remove(at: index)
    }

    return targets
}

let package = Package(
    name: "Site",
    platforms: [.iOS("13.4"), .macOS("11")],
    products: [
        .executable(name: "site", targets: ["Site"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Site",
            dependencies: ["Files", "Plot", "Publish", "UserModule"],
            path: page + "/My Playground.playgroundpage",
            exclude: ["Manifest.plist"],
            sources: ["main.swift"],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("Network"),
            ]
        ),
        .target(
            name: "Codextended",
            path: userModules,
            exclude: excludes(for: "Codextended.playgroundmodule"),
            sources: ["Codextended.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "Files",
            path: userModules,
            exclude: excludes(for: "Files.playgroundmodule"),
            sources: ["Files.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "Ink",
            path: userModules,
            exclude: excludes(for: "Ink.playgroundmodule"),
            sources: ["Ink.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "Plot",
            path: userModules,
            exclude: excludes(for: "Plot.playgroundmodule"),
            sources: ["Plot.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "Publish",
            dependencies: ["Codextended", "Files", "Ink", "Plot", "Sweep"],
            path: userModules,
            exclude: excludes(for: "Publish.playgroundmodule"),
            sources: ["Publish.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "Sweep",
            path: userModules,
            exclude: excludes(for: "Sweep.playgroundmodule"),
            sources: ["Sweep.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "UserModule",
            dependencies: ["Publish"],
            path: userModules,
            exclude: excludes(for: "UserModule.playgroundmodule"),
            sources: ["UserModule.playgroundmodule"],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("System"),
                .linkedFramework("UniformTypeIdentifiers"),
                .linkedLibrary("AppleArchive"),
            ]
        ),
    ]
)
