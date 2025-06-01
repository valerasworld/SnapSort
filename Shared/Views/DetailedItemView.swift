//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI

struct DetailedItemView: View {
    let infoObject: InfoObject
    @Environment(Favorites.self) var favorites
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                BackButtonView()

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
                            .foregroundStyle(Color.black)
                            .font(.title3)
                            .bold()
                        
                        
//                        Text(infoObject.description ?? "")
//                            .foregroundStyle(.black)
//                            .font(.body)
                    }
                    .padding(.horizontal)
                    
                    TagsView(tags: infoObject.tags)
                        .padding(.horizontal)
                    
                }
               
                Button(favorites.contains(infoObject: infoObject) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(infoObject: infoObject) {
                                    favorites.remove(infoObject)
                                } else {
                                    favorites.add(infoObject: infoObject)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                
            }
            .navigationBarBackButtonHidden(true)
        }
        }
    }


#Preview {
   DetailedItemView(infoObject: SampleObjects.contents.first!)
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
