import Foundation
import Plot
import Publish

extension A2 {
    public struct Website: Publish.Website {
        public struct SectionID: WebsiteSectionID {
            public static var allCases: [A2.Website.SectionID] { [] }

            public init?(rawValue: String) { nil }

            public var rawValue: String { fatalError() }
        }
        
        public struct ItemMetadata: WebsiteItemMetadata {
            public init() {}
        }
        
        public var url = URL(string: "https://a2.io")!
        public var name = "Alexsander Akers"
        public var description = "The personal website of Alexsander Akers."
        public var language: Language { .english }
        public var imagePath: Path? { nil }
        public var favicon: Favicon? { Favicon(path: "/favicon.png", type: "image/png") }
        public var tagHTMLConfig: TagHTMLConfiguration? { nil }

        public init() {}
    }
}
