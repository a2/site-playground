import Foundation
import Plot
import Publish

extension A2 {
    struct Website: Publish.Website {
        enum SectionID: String, WebsiteSectionID {
            case about
            case work
            case contact
        }
        
        struct ItemMetadata: WebsiteItemMetadata {}
        
        var url = URL(string: "https://a2.io")!
        let name = "Alexsander Akers"
        let subtitle = "Software Engineer"
        let description = "The personal website of Alexsander Akers."
        var language: Language { .english }
        var imagePath: Path? { nil }
    }
}
