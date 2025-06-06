//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI
import SwiftData

struct DetailedItemView: View {
    let infoObject: InfoObject
//    @Environment(Favorites.self) var favorites
    @Environment(\.dismiss) var dismiss
    
    @State var isEditing: Bool = false
    
    @Query var infoObjects: [InfoObject]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .bottomLeading) {
                    if let image = infoObject.image {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            Color.black
                                .opacity(0.03)
                        }
                        
                    } else {
                        ZStack {
                            LinearGradient(colors: [.white, infoObject.category.color], startPoint: .bottom, endPoint: .top)
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                            Color.clear
                                .background(.ultraThinMaterial)
                        }
                    }
                    if infoObject.stringURL != nil && infoObject.stringURL != "" {
                        LinkButtonOnDetailView(infoObject: infoObject)
                    }
                }
                .frame(maxWidth: .infinity)
                
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
                
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
                ToolbarItem {
                    Button {
                        infoObject.isFavorite.toggle()
                    } label: {
                        Image(systemName: infoObject.isFavorite ? "heart.fill" : "heart")
                    }
                }
                ToolbarItem {
                    Button {
                        isEditing.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                AddItemView(infoObject: infoObject, isEditing: true, infoObjects: infoObjects)
            }
            
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
//        .background(Color(.systemBackground))
        .zIndex(1)
    }
}

struct LinkButtonOnDetailView: View {
    var infoObject: InfoObject
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "link")
                Text(URL(string: infoObject.stringURL ?? " ")?.host?.replacingOccurrences(of: "www.", with: "") ?? "")
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .font(.body)
            .bold()
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(infoObject.category.color)
            }
            .padding()
        }
        
    }
}
