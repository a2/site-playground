import Files
import Foundation
import Network
import Plot
import Publish

#if canImport(PlaygroundSupport)
import PlaygroundSupport
#endif

let fileManager = InMemoryFileManager()

// Required for Foundation theme
/*
try fileManager.createDirectory(atPath: "/Resources/FoundationTheme", withIntermediateDirectories: true)
_ = fileManager.createFile(atPath: "/Package.swift", contents: nil)
_ = fileManager.createFile(atPath: "/Theme+Foundation.swift", contents: nil)
_ = fileManager.createFile(atPath: "/Resources/FoundationTheme/styles.css", contents: Data(base64Encoded: "LyoqCiogIFB1Ymxpc2ggRm91bmRhdGlvbiB0aGVtZQoqICBDb3B5cmlnaHQgKGMpIEpvaG4gU3VuZGVsbCAyMDE5CiogIE1JVCBsaWNlbnNlLCBzZWUgTElDRU5TRSBmaWxlIGZvciBkZXRhaWxzCiovCgoqIHsKICAgIG1hcmdpbjogMDsKICAgIHBhZGRpbmc6IDA7CiAgICBib3gtc2l6aW5nOiBib3JkZXItYm94Owp9Cgpib2R5IHsKICAgIGJhY2tncm91bmQ6ICNmZmY7CiAgICBjb2xvcjogIzAwMDsKICAgIGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2EsIEFyaWFsOwogICAgdGV4dC1hbGlnbjogY2VudGVyOwp9Cgoud3JhcHBlciB7CiAgICBtYXgtd2lkdGg6IDkwMHB4OwogICAgbWFyZ2luLWxlZnQ6IGF1dG87CiAgICBtYXJnaW4tcmlnaHQ6IGF1dG87CiAgICBwYWRkaW5nOiA0MHB4OwogICAgdGV4dC1hbGlnbjogbGVmdDsKfQoKaGVhZGVyIHsKICAgIGJhY2tncm91bmQtY29sb3I6ICNlZWU7Cn0KCmhlYWRlciAud3JhcHBlciB7CiAgICBwYWRkaW5nLXRvcDogMzBweDsKICAgIHBhZGRpbmctYm90dG9tOiAzMHB4OwogICAgdGV4dC1hbGlnbjogY2VudGVyOwp9CgpoZWFkZXIgYSB7CiAgICB0ZXh0LWRlY29yYXRpb246IG5vbmU7Cn0KCmhlYWRlciAuc2l0ZS1uYW1lIHsKICAgIGZvbnQtc2l6ZTogMS41ZW07CiAgICBjb2xvcjogIzAwMDsKICAgIGZvbnQtd2VpZ2h0OiBib2xkOwp9CgpuYXYgewogICAgbWFyZ2luLXRvcDogMjBweDsKfQoKbmF2IGxpIHsKICAgIGRpc3BsYXk6IGlubGluZS1ibG9jazsKICAgIG1hcmdpbjogMCA3cHg7CiAgICBsaW5lLWhlaWdodDogMS41ZW07Cn0KCm5hdiBsaSBhLnNlbGVjdGVkIHsKICAgIHRleHQtZGVjb3JhdGlvbjogdW5kZXJsaW5lOwp9CgpoMSB7CiAgICBtYXJnaW4tYm90dG9tOiAyMHB4OwogICAgZm9udC1zaXplOiAyZW07Cn0KCmgyIHsKICAgIG1hcmdpbjogMjBweCAwOwp9CgpwIHsKICAgIG1hcmdpbi1ib3R0b206IDEwcHg7Cn0KCmEgewogICAgY29sb3I6IGluaGVyaXQ7Cn0KCi5kZXNjcmlwdGlvbiB7CiAgICBtYXJnaW4tYm90dG9tOiA0MHB4Owp9CgouaXRlbS1saXN0ID4gbGkgewogICAgZGlzcGxheTogYmxvY2s7CiAgICBwYWRkaW5nOiAyMHB4OwogICAgYm9yZGVyLXJhZGl1czogMjBweDsKICAgIGJhY2tncm91bmQtY29sb3I6ICNlZWU7CiAgICBtYXJnaW4tYm90dG9tOiAyMHB4Owp9CgouaXRlbS1saXN0ID4gbGk6bGFzdC1jaGlsZCB7CiAgICBtYXJnaW4tYm90dG9tOiAwOwp9CgouaXRlbS1saXN0IGgxIHsKICAgIG1hcmdpbi1ib3R0b206IDE1cHg7CiAgICBmb250LXNpemU6IDEuM2VtOwp9CgouaXRlbS1saXN0IHAgewogICAgbWFyZ2luLWJvdHRvbTogMDsKfQoKLnRhZy1saXN0IHsKICAgIG1hcmdpbi1ib3R0b206IDE1cHg7Cn0KCi50YWctbGlzdCBsaSwKLnRhZyB7CiAgICBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7CiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjMDAwOwogICAgY29sb3I6ICNkZGQ7CiAgICBwYWRkaW5nOiA0cHggNnB4OwogICAgYm9yZGVyLXJhZGl1czogNXB4OwogICAgbWFyZ2luLXJpZ2h0OiA1cHg7Cn0KCi50YWctbGlzdCBhLAoudGFnIGEgewogICAgdGV4dC1kZWNvcmF0aW9uOiBub25lOwp9CgouaXRlbS1wYWdlIC50YWctbGlzdCB7CiAgICBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7Cn0KCi5jb250ZW50IHsKICAgIG1hcmdpbi1ib3R0b206IDQwcHg7Cn0KCi5icm93c2UtYWxsIHsKICAgIGRpc3BsYXk6IGJsb2NrOwogICAgbWFyZ2luLWJvdHRvbTogMzBweDsKfQoKLmFsbC10YWdzIGxpIHsKICAgIGZvbnQtc2l6ZTogMS40ZW07CiAgICBtYXJnaW4tcmlnaHQ6IDEwcHg7CiAgICBwYWRkaW5nOiA2cHggMTBweDsKfQoKZm9vdGVyIHsKICAgIGNvbG9yOiAjOGE4YThhOwp9CgpAbWVkaWEgKHByZWZlcnMtY29sb3Itc2NoZW1lOiBkYXJrKSB7CiAgICBib2R5IHsKICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjMjIyOwogICAgfQoKICAgIGJvZHksCiAgICBoZWFkZXIgLnNpdGUtbmFtZSB7CiAgICAgICAgY29sb3I6ICNkZGQ7CiAgICB9CgogICAgLml0ZW0tbGlzdCA+IGxpIHsKICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjMzMzOwogICAgfQoKICAgIGhlYWRlciB7CiAgICAgICAgYmFja2dyb3VuZC1jb2xvcjogIzAwMDsKICAgIH0KfQoKQG1lZGlhKG1heC13aWR0aDogNjAwcHgpIHsKICAgIC53cmFwcGVyIHsKICAgICAgICBwYWRkaW5nOiA0MHB4IDIwcHg7CiAgICB9Cn0K")!)
*/

try fileManager.createDirectory(atPath: "/Content", withIntermediateDirectories: true)

_ = fileManager.createFile(atPath: "/Content/index.md", contents: Data("""
---
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit. In euismod hendrerit dolor, eu pretium sem condimentum quis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consectetur odio accumsan odio tempus consectetur. In metus ex, rhoncus a ultrices vitae, venenatis facilisis mi. Quisque feugiat nisl nec lorem molestie cursus. Ut placerat nisl vitae risus mattis, semper porta felis fringilla. Aenean id lectus orci. Nulla euismod eleifend dui. Aenean dui magna, varius vel consectetur a, gravida ac ante.

Nam mollis faucibus eros at pellentesque. Aenean lacinia auctor velit, et faucibus metus commodo vel. Phasellus bibendum commodo mi vitae scelerisque. Curabitur sodales facilisis orci, ac tristique ligula dictum ut. Phasellus sed blandit lacus. Duis iaculis sapien at lorem tempus, at bibendum leo tincidunt. Aliquam aliquet nunc tellus, sed laoreet ligula sollicitudin ac.

Integer molestie consequat ante id malesuada. Vivamus aliquet tellus in enim tempor fringilla. Aliquam eleifend elementum interdum. Nullam id felis et eros pharetra sodales nec sit amet eros. Maecenas eget venenatis risus, at aliquam tellus. Donec aliquet nulla enim, sed vestibulum lorem pretium quis. Nam sit amet tellus quis risus tristique lobortis eget non turpis. In nibh est, luctus ac ante eu, feugiat consectetur quam. Aenean at consectetur erat. Nullam dolor lacus, sagittis nec suscipit ut, sagittis quis mi.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/babelgum.md", contents: Data("""
---
---

Vestibulum quam eros, euismod id magna in, vehicula sollicitudin erat. Quisque eu elit volutpat, congue augue vitae, ullamcorper risus. Aliquam quis justo blandit, tincidunt felis vel, aliquet orci. Sed porta tortor risus, id facilisis mauris auctor scelerisque. Nunc egestas nunc tellus, placerat porta odio pharetra sed. Duis a vestibulum orci. Donec nec orci tincidunt, feugiat mi tempus, euismod felis. Ut non leo eget nisi pellentesque condimentum euismod at sem. Maecenas et convallis nibh. Nullam quis augue gravida, hendrerit ante at, maximus massa. Nam tincidunt, sem id hendrerit interdum, est leo finibus purus, eget blandit diam nunc nec felis. Integer sed sapien vestibulum felis feugiat eleifend. Suspendisse mi metus, placerat id vestibulum at, mattis ac magna. Maecenas consectetur aliquet feugiat.

Nulla facilisi. Nunc sagittis ipsum sed massa tristique laoreet. Nunc eu scelerisque massa. Cras rutrum sem id tempor volutpat. Sed ac pretium purus. Nulla ut posuere diam. Proin non placerat arcu. Cras malesuada aliquet leo tempus luctus. In consectetur lobortis dolor at rhoncus. Ut at odio a lectus efficitur posuere a tincidunt leo. Fusce nec odio sagittis quam placerat laoreet. Sed malesuada varius odio, porttitor pulvinar quam feugiat sed. Cras velit mauris, mollis at finibus quis, congue eu mauris. Cras at mi enim. Etiam placerat fringilla rutrum.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/backgammon.md", contents: Data("""
---
---

Suspendisse ut tristique velit. Quisque dignissim magna lacinia mattis ultrices. Duis tempus consectetur erat at euismod. Donec vel lacus quam. Ut at lobortis diam. Morbi dictum interdum est eget aliquet. Mauris at enim efficitur, bibendum libero sit amet, iaculis lectus. Mauris vestibulum nunc est, quis congue nunc tincidunt rutrum. Cras non nisi dictum, placerat justo eget, facilisis ligula. Donec sit amet lorem dui. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris ac condimentum nibh. Nam facilisis, metus et condimentum maximus, libero odio hendrerit nisi, eget tempor magna diam sit amet tortor. Sed nec dui elit. Vivamus semper tellus ut est finibus sollicitudin.

Praesent eu sem a turpis sagittis porttitor interdum non nibh. Aenean ornare risus eu ipsum ullamcorper aliquam a id dui. Nullam sodales rhoncus nunc. Pellentesque in imperdiet metus, ut elementum nulla. Praesent commodo sagittis leo nec aliquam. Nullam ipsum sem, auctor sit amet mi vel, porta semper eros. Fusce est risus, euismod quis ullamcorper ut, efficitur in felis. Nullam at gravida velit, a suscipit nunc. Ut justo tellus, mattis at euismod eget, fringilla non mauris. Ut ornare lacus nulla, ut semper nisi euismod consequat. Maecenas malesuada tortor eu erat dignissim, at aliquam dui luctus. Sed efficitur lobortis ante, in fermentum diam luctus quis. Donec egestas purus vel sapien efficitur pellentesque. Sed ac felis pulvinar leo bibendum tincidunt.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/bean.md", contents: Data("""
---
---

Aliquam convallis iaculis tempus. Integer suscipit rutrum ex sit amet interdum. Sed elementum ante sit amet lobortis dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet ipsum efficitur, dictum urna euismod, tincidunt leo. Mauris imperdiet, ex finibus tincidunt dictum, ex nibh venenatis dolor, a eleifend nunc lorem et purus. Nulla sit amet interdum elit. Fusce lectus augue, scelerisque a metus eu, maximus rhoncus nibh. Donec commodo, eros at viverra consectetur, lacus odio cursus leo, nec condimentum lorem turpis id nisi. Sed in enim pharetra nisi venenatis tincidunt.

Vivamus sed tincidunt dolor, eget feugiat elit. Vivamus sit amet sapien at enim venenatis auctor quis vel turpis. Integer sed volutpat odio. Praesent eget ex sit amet lacus blandit semper. Morbi pretium fringilla dui, quis semper arcu tempus eu. Donec tempus mauris lectus, non iaculis dui elementum eget. Phasellus elit massa, mollis quis sodales hendrerit, convallis ac erat. Fusce accumsan, risus ac euismod fringilla, metus quam tempus odio, volutpat imperdiet arcu dui at leo. Etiam sed imperdiet lectus. Sed tincidunt, leo faucibus rutrum porttitor, odio sem sodales orci, sit amet sollicitudin arcu ante sit amet nisi. Nunc in tempus massa. Quisque molestie, dolor sed pharetra bibendum, purus elit scelerisque ligula, a porttitor massa turpis quis purus. Maecenas maximus arcu risus, vel suscipit est posuere eget. Mauris consequat molestie tincidunt. Proin et venenatis velit, a luctus ipsum.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/foursquare.md", contents: Data("""
---
---

Ut dapibus leo quis nulla faucibus, non molestie dolor elementum. Phasellus sed pellentesque eros. Suspendisse at libero lacus. Sed ultrices malesuada orci, vel suscipit tortor lobortis id. Aenean posuere ullamcorper tincidunt. Nam metus metus, maximus id sapien ut, eleifend interdum sapien. Phasellus eu urna eu ex porta porta. Suspendisse ullamcorper rhoncus convallis. Suspendisse vulputate felis sapien, sit amet lacinia nisi tincidunt sed. Nunc sollicitudin velit at velit venenatis, feugiat vehicula arcu volutpat. Aenean lobortis ullamcorper viverra.

Curabitur aliquet, lacus at porta porttitor, metus risus lobortis est, id volutpat diam nisi id ex. Sed eu velit pellentesque, condimentum arcu eget, tempor purus. Donec fermentum iaculis hendrerit. Duis tristique leo id risus commodo, eget tempus velit tristique. Aliquam eget iaculis neque. Cras vestibulum tristique nunc, eu ultricies neque. Aliquam sagittis lacus mattis, ultrices dui at, interdum enim. Vivamus varius purus a tempor ullamcorper. Fusce rhoncus rhoncus nibh a pretium.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/outlook.md", contents: Data("""
---
---

Aliquam blandit aliquet finibus. Vivamus pellentesque sodales tempus. Cras sollicitudin magna venenatis augue laoreet, vitae ultricies felis lacinia. Suspendisse vehicula, ante vel varius laoreet, purus purus aliquet felis, sed dictum nibh leo quis libero. Vivamus scelerisque nunc sit amet sem blandit, eget lobortis diam dignissim. Aenean sollicitudin, justo non vulputate scelerisque, enim enim luctus lectus, quis commodo nisi nisl nec enim. Nam dapibus est vel odio auctor, semper rhoncus diam tempor.

Praesent accumsan eu purus vitae molestie. Sed accumsan, urna quis aliquam consectetur, justo risus venenatis purus, quis egestas arcu turpis in quam. Pellentesque viverra at justo sed aliquet. Nullam eros erat, pharetra et est eu, efficitur hendrerit dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras fringilla turpis eget erat ultricies, at sodales risus dignissim. Morbi a leo a erat gravida molestie. Praesent non est a eros cursus vulputate eget lobortis magna. Nullam sollicitudin tortor orci, condimentum lobortis leo malesuada nec. Ut vulputate purus et est tristique sodales. Mauris volutpat augue augue. Aliquam aliquam convallis ante in sollicitudin. Duis ac lacus pretium, convallis eros et, efficitur elit. Morbi pellentesque tortor vitae venenatis blandit. Quisque laoreet rutrum risus, et faucibus velit maximus tempor.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/rooms.md", contents: Data("""
---
---

Duis non libero sed erat pellentesque molestie. Donec mattis at dolor et imperdiet. Mauris dictum sollicitudin felis non porta. Phasellus fringilla cursus mi ac porttitor. Donec pulvinar iaculis nisl quis convallis. In hac habitasse platea dictumst. Curabitur lacinia egestas ultricies. Suspendisse ac leo tellus. Donec sit amet finibus mi, ac ullamcorper purus. Fusce congue mauris a erat blandit auctor. Duis sed elementum arcu.

Vivamus at vulputate diam, vitae placerat nisl. In enim ex, euismod in nisi eu, pharetra efficitur felis. Sed in quam mattis, posuere eros tincidunt, imperdiet nulla. Aenean porta nibh in tortor faucibus, non lacinia orci elementum. Suspendisse potenti. Nulla fringilla eu dolor quis efficitur. Vestibulum ac arcu sed quam fermentum convallis at vel nibh. Etiam suscipit hendrerit dui, nec maximus tellus molestie ornare.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/shutterstock.md", contents: Data("""
---
---

Mauris consequat metus in turpis dapibus tristique. Curabitur ut mattis justo. Curabitur quam ipsum, tincidunt sit amet suscipit ut, posuere vitae nulla. Mauris placerat porta nulla vel dapibus. Curabitur rhoncus hendrerit commodo. Praesent varius magna justo, ac finibus nibh tincidunt in. Praesent ut lectus a nunc suscipit consectetur. Quisque et eros ac orci efficitur vehicula. Sed vel augue tincidunt, blandit ante vel, porttitor urna. In congue est eget pellentesque luctus. Ut sed tempus tortor, ac ultricies mauris. Donec ac felis ut nisl gravida blandit eu vitae lorem. Nulla bibendum, ante sit amet rhoncus iaculis, justo lorem hendrerit mauris, in egestas eros est vel arcu. Phasellus euismod vehicula est, a lobortis nisl. Nullam molestie rhoncus porta.

Etiam est tellus, tristique quis justo sit amet, pretium elementum neque. Vivamus at turpis purus. Sed eleifend elit sed turpis facilisis faucibus. Praesent euismod, dolor in laoreet elementum, est leo aliquam neque, ut viverra velit velit ut sem. Pellentesque lacus justo, consequat fermentum sem in, aliquam facilisis ex. Mauris malesuada eget ipsum at convallis. Morbi at quam erat. Morbi eleifend magna imperdiet magna volutpat, quis ullamcorper dui varius.
""".utf8))

_ = fileManager.createFile(atPath: "/Apps/to-do.md", contents: Data("""
---
---

Nunc lobortis, justo eget dictum cursus, purus est eleifend nulla, vitae hendrerit mauris lectus in odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed consectetur, arcu efficitur rutrum malesuada, mi ex laoreet justo, vitae rutrum sapien magna non erat. Morbi egestas venenatis tellus congue semper. Donec nisl tellus, ullamcorper id massa id, elementum vulputate erat. Vivamus tempus, enim vel ullamcorper iaculis, dolor risus ultrices mi, et faucibus odio ligula et orci. Morbi volutpat ligula a magna efficitur volutpat. Nam sed viverra libero, sed luctus tellus. Vivamus tempor non eros tempus tincidunt. Vivamus gravida nec sem vitae scelerisque. Nunc ut felis ante. Mauris tempus auctor massa, ac vulputate eros pretium ac. Quisque molestie mauris non mi volutpat, ut scelerisque odio luctus. Donec eget diam at erat fermentum cursus.

Duis iaculis nibh nec nunc fringilla pellentesque. Vivamus aliquam lacus at leo lobortis, vitae scelerisque dui commodo. Proin sed ligula interdum, tristique nisl in, gravida urna. Ut porta in lorem non volutpat. Ut ac nibh vel mi ultrices fermentum vitae ut ex. Nullam ac nisl nec velit consequat ultrices ac nec sem. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse at magna ac mi dictum ultrices eget at libero. Nam ac eros est. Nam a sollicitudin lacus, nec tincidunt diam.
""".utf8))

// _ = fileManager.createFile(atPath: "/Content/about.md", contents: Data("---\n---\n\nHi, I'm Alex!".utf8))
// _ = fileManager.createFile(atPath: "/Content/work.md", contents: Data("---\n---\n\nAlex works for Microsoft in NYC.".utf8))
// _ = fileManager.createFile(atPath: "/Content/contact.md", contents: Data("---\n---\n\n".utf8))

let indentation = Indentation.Kind.spaces(2)
let publishedWebsite = try fileManager.performAsDefault {
    try A2.Website().publish(at: Path("/"), using: [
        .addMarkdownFiles(),
        /*
        .step(named: "Add Markdown files from 'Content' folder") { context in
            let parentPath: Path = "Content"
            let folder = try context.folder(at: parentPath)
            let markdownExtensions: Set<String> = ["md", "markdown", "txt", "text"]
            let now = Date()

            for file in folder.files {
                guard markdownExtensions.contains(where: { ext in ext.caseInsensitiveCompare(file.extension ?? "") == .orderedSame }) else {
                    continue
                }

                let fileContents = try file.readAsString()
                let markdown = context.markdownParser.parse(fileContents)
                let body = Content.Body(html: markdown.html)

                let content = Content(title: "", description: "", body: body, date: now, lastModified: now)
                let item = Item<A2.Website>(path: Path("#\(file.nameExcludingExtension)"), sectionID: .work, metadata: .init(), tags: [], content: content, rssProperties: .init())
                context.addItem(item)
            }
        },
        */
        .generateHTML(withTheme: A2.theme, indentation: indentation),
        .generateRSSFeed(including: Set(A2.Website.SectionID.allCases), config: .init(indentation: indentation)),
        .generateSiteMap(indentedBy: indentation)
    ])
}

let outputPath = "/Output/"
let paths = try fileManager.subpathsOfDirectory(atPath: outputPath)
    .map { path in "- " + path[String.Index(outputPath.endIndex, within: outputPath)!...]}
    .sorted()
    .joined(separator: "\n")

print()
print("Generated files:", paths, separator: "\n")
print()

let server = Server(fileManager: fileManager)
try server.start(port: 8000)

RunLoop.current.run()
