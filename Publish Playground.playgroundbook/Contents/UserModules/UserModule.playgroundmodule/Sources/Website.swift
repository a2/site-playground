import Foundation
import Plot
import Publish

extension A2 {
    public struct Website: Publish.Website {
        public enum SectionID: String, WebsiteSectionID {
            case unknown = "404"
        }
        
        public struct ItemMetadata: WebsiteItemMetadata {}
        
        public var url = URL(string: "https://a2.io")!
        public var name = "Alexsander Akers"
        public var description = "The personal website of Alexsander Akers."
        public var language: Language { .english }
        public var imagePath: Path? { nil }
        public var tagHTMLConfig: TagHTMLConfiguration? { nil }

        public init() {}
    }
}
