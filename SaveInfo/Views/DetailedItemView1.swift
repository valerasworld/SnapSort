//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI

struct DetailedItemView1: View {
    let infoObject: InfoObject
    let category: Category
    
    var body: some View {
        
        VStack {
                Image("image1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
            
            Text(infoObject.title ?? "")
                .foregroundStyle(category.color)
            
        }
    }
}

#Preview {
    @Previewable
    @State var infoObject = InfoObject(
        title: "Among Us",
        image: UIImage(contentsOfFile: "image1"),
        category: .electronics,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    
    DetailedItemView1(infoObject: infoObject, category: .electronics)
}
