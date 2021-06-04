import Foundation

public struct LocalResource: _ExpressibleByFileReferenceLiteral {
    private let rawPath: String

    public init(fileReferenceLiteralResourceName path: String) {
        self.rawPath = path
    }

    public var fileURL: URL {
        #if canImport(PlaygroundSupport)
        return URL(fileReferenceLiteralResourceName: rawPath)
        #else
        let relativePath = URL(fileURLWithPath: "../../../PublicResources/", isDirectory: true, relativeTo: URL(fileURLWithPath: #filePath))
        return URL(fileURLWithPath: rawPath, relativeTo: relativePath)
        #endif
    }
}

public extension LocalResource {
    static var all: [LocalResource] {
        [
            #fileLiteral(resourceName: "Apps___babelgum.md"), // Apps/babelgum.md
            #fileLiteral(resourceName: "Apps___backgammon.md"), // Apps/backgammon.md
            #fileLiteral(resourceName: "Apps___bean.md"), // Apps/bean.md
            #fileLiteral(resourceName: "Apps___foursquare.md"), // Apps/foursquare.md
            #fileLiteral(resourceName: "Apps___outlook.md"), // Apps/outlook.md
            #fileLiteral(resourceName: "Apps___potluck.md"), // Apps/potluck.md
            #fileLiteral(resourceName: "Apps___rooms.md"), // Apps/rooms.md
            #fileLiteral(resourceName: "Apps___shutterstock.md"), // Apps/shutterstock.md
            #fileLiteral(resourceName: "Apps___to-do.md"), // Apps/to-do.md
            #fileLiteral(resourceName: "Content___index.md"), // Content/index.md
            #fileLiteral(resourceName: "Resources___images___background.jpg"), // Resources/images/background.jpg
            #fileLiteral(resourceName: "Resources___images___icons___babelgum.png"), // Resources/images/icons/babelgum.png
            #fileLiteral(resourceName: "Resources___images___icons___backgammon.png"), // Resources/images/icons/backgammon.png
            #fileLiteral(resourceName: "Resources___images___icons___bean.png"), // Resources/images/icons/bean.png
            #fileLiteral(resourceName: "Resources___images___icons___blank.png"), // Resources/images/icons/blank.png
            #fileLiteral(resourceName: "Resources___images___icons___contacts.png"), // Resources/images/icons/contacts.png
            #fileLiteral(resourceName: "Resources___images___icons___foursquare.png"), // Resources/images/icons/foursquare.png
            #fileLiteral(resourceName: "Resources___images___icons___mail.png"), // Resources/images/icons/mail.png
            #fileLiteral(resourceName: "Resources___images___icons___maps.png"), // Resources/images/icons/maps.png
            #fileLiteral(resourceName: "Resources___images___icons___messages.png"), // Resources/images/icons/messages.png
            #fileLiteral(resourceName: "Resources___images___icons___music.png"), // Resources/images/icons/music.png
            #fileLiteral(resourceName: "Resources___images___icons___outlook.png"), // Resources/images/icons/outlook.png
            #fileLiteral(resourceName: "Resources___images___icons___photos.png"), // Resources/images/icons/photos.png
            #fileLiteral(resourceName: "Resources___images___icons___potluck.png"), // Resources/images/icons/potluck.png
            #fileLiteral(resourceName: "Resources___images___icons___rooms.png"), // Resources/images/icons/rooms.png
            #fileLiteral(resourceName: "Resources___images___icons___safari.png"), // Resources/images/icons/safari.png
            #fileLiteral(resourceName: "Resources___images___icons___shutterstock.png"), // Resources/images/icons/shutterstock.png
            #fileLiteral(resourceName: "Resources___images___icons___to-do.png"), // Resources/images/icons/to-do.png
            #fileLiteral(resourceName: "Resources___images___icons___twitter.png"), // Resources/images/icons/twitter.png
            #fileLiteral(resourceName: "Resources___images___screens___babelgum.jpg"), // Resources/images/screens/babelgum.jpg
            #fileLiteral(resourceName: "Resources___images___screens___backgammon.jpg"), // Resources/images/screens/backgammon.jpg
            #fileLiteral(resourceName: "Resources___images___screens___bean.jpg"), // Resources/images/screens/bean.jpg
            #fileLiteral(resourceName: "Resources___images___screens___foursquare.jpg"), // Resources/images/screens/foursquare.jpg
            #fileLiteral(resourceName: "Resources___images___screens___outlook.jpg"), // Resources/images/screens/outlook.jpg
            #fileLiteral(resourceName: "Resources___images___screens___potluck.jpg"), // Resources/images/screens/potluck.jpg
            #fileLiteral(resourceName: "Resources___images___screens___rooms.jpg"), // Resources/images/screens/rooms.jpg
            #fileLiteral(resourceName: "Resources___images___screens___shutterstock.jpg"), // Resources/images/screens/shutterstock.jpg
            #fileLiteral(resourceName: "Resources___images___screens___to-do.jpg"), // Resources/images/screens/to-do.jpg
        ]
    }
}
