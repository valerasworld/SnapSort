//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI

struct DetailedItemView: View {
    let infoObject: InfoObject
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                BackButtonView()
                
                //            VStack {
                //                ZStack {
                //                    Text(" ")
                //                        .font(.title3)
                //                        .bold()
                //                        .frame(maxWidth: .infinity)
                ////                        .overlay(alignment: .leading) {
                ////                            HStack {
                ////                                Button ("Cancel") {
                ////
                ////                                }
                ////                                .tint(.red)
                ////                                Spacer()
                ////                                Button ("Edit") {
                ////
                ////                                }
                ////                            }
                ////                        }
                //
                //                    Spacer (minLength: 0)
            }
            
            .padding([.leading, .trailing, .top])
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
                    Group {
                        Text(infoObject.title ?? "")
                        //                            .foregroundStyle(infoObject.category.color)
                            .foregroundStyle(Color.black)
                            .font(.title3)
                            .bold()
                        
                        
                        Text(infoObject.description ?? "")
                            .foregroundStyle(.black)
                            .font(.body)
                    }
                    .padding(.horizontal)
                    
                    TagsView(infoObject: infoObject)
                        .padding(.horizontal)
                    
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
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
    
    @Previewable
    @State var infoObject2 = InfoObject(
//        title: "Harry Potter",
        description: "Renata is the best actress of the Moscow Art Theater",
        author: "J.K. Rowling",
        stringURL: "https://t.me/renatalitvinova/5500",
        tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"],
        category: .restaurants,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 1))!)
    
    DetailedItemView(infoObject: infoObject2)
}

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.body)
                .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding([.top, .horizontal], 2)
        .background(Color(.systemBackground))
        .zIndex(1)
    }
}
