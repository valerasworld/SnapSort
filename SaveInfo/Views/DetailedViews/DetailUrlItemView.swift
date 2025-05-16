//
//  DetailUrlItemView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 14/05/25.
//
//
//  DetailedUrlItemView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 14/05/25.
//

import SwiftUI
import UniformTypeIdentifiers
import LinkPresentation

struct DetailUrlItemView: View {
    let infoObject: InfoObject
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
//                Image(infoObject.image)
                                
                Text(infoObject.stringURL ?? "")
                    .font(.title3)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .fill(infoObject.category.color.opacity(0.2)))
                
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        UIPasteboard.general.string = infoObject.stringURL ?? ""
                    }) {
                        Text("Copy Link")
                    }
                    
                    Button(action: {
                    }) {
                        Text("Visit Link")
                    }
                }
                .padding(.horizontal, 80)
                .buttonStyle(.bordered)
                
                VStack(alignment: .leading) {
                    Text(infoObject.title ?? "")
                        .foregroundStyle(infoObject.category.color)
                        .font(.title3)
                        .bold()
                    
                    
                    Text(infoObject.description ?? "")
                        .font(.title3)
                    
                    TagsView(infoObject: infoObject)
                }
                
            }
            .padding(.horizontal)
        }
        .onTapGesture(count: 2) {
            let clipboard = UIPasteboard.general
            clipboard.setValue(infoObject.linkURL ?? "" as Any, forPasteboardType: UTType.plainText.identifier)
        }
    }
}

struct LinkPreviewView: UIViewRepresentable {
    let metadata: LPLinkMetadata

    func makeUIView(context: Context) -> LPLinkView {
        return LPLinkView(metadata: metadata)
    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {
        uiView.metadata = metadata
    }
}



#Preview {
    @Previewable
    @State var infoObject = InfoObject(
        title: "Nike Air Force",
        description: "Lore ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum. Nam viverra fringilla erat, ut fermentum nunc feugiat eu.",
        image: UIImage(contentsOfFile: "image2"),
        stringURL: "https://www.zalando.it/nike-sportswear-air-force-1-sneakers-basse-whiteblack-ni112o0h3-a11.html",
        tags: ["Clothes", "Party game", "Vintage"],
        category: .clothes,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    
    DetailUrlItemView(infoObject: infoObject)
}
