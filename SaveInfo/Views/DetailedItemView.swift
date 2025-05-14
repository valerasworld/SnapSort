//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI

struct DetailedItemView: View {
    let infoObject: InfoObject
    
    var body: some View {
        ScrollView {
            if let image = infoObject.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    Color.black
                        .opacity(0.03)
                }
            }
            VStack(alignment: .leading) {
                
                
                Text(infoObject.title ?? "")
                    .foregroundStyle(infoObject.category.color)
                    .font(.title3)
                    .bold()
                
                Text(infoObject.description ?? "")
                    .foregroundStyle(.black)
                    .font(.body)
                
                TagsView(infoObject: infoObject)
                    
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @Previewable
    @State var infoObject = InfoObject(
        title: "Among Us",
        description: "Lore ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum. Nam viverra fringilla erat, ut fermentum nunc feugiat eu.",
        image: UIImage(contentsOfFile: "image1"),
        tags: ["Multiplayer", "Party game"],
        category: .electronics,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    
    DetailedItemView(infoObject: infoObject)
}
