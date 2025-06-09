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
    @State var imageIsClicked: Bool = false
    
    @Query var infoObjects: [InfoObject]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !imageIsClicked {
                    ZStack(alignment: .bottomLeading) {
//                    if let image = infoObject.image {
//                        ZStack {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(maxWidth: .infinity)
//                            Color.black
//                                .opacity(0.03)
//                        }
//
//                    } else {
//                        ZStack {
//                            LinearGradient(colors: [.white, infoObject.category.color], startPoint: .bottom, endPoint: .top)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 200)
//                            Color.clear
//                                .background(.ultraThinMaterial)
//                        }
//                    }
                        let width = UIScreen.main.bounds.width
                        
                        ZStack {
                            // BG IMAGE
                            if let uiimage = infoObject.image {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(1/1, contentMode: .fill)
                                    .frame(maxWidth: width, maxHeight: width)
                                    .clipped()
                                    
                                LinearGradient(colors: [.white, .clear, . clear], startPoint: .bottom, endPoint: .top)
                            }
                            
                            Color.clear
                                .background(.ultraThinMaterial)
                            
                            
                            ZStack {
                                if let uiimage = infoObject.image {
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .frame(maxWidth: width * 0.8, maxHeight: width * 0.65)
                                        .shadow(color: .black.opacity(0.27), radius: 10, x: 0, y: 5)
                                        .onTapGesture {
                                            imageIsClicked.toggle()
                                        }
                                } else {
                                    ZStack {
                                        LinearGradient(colors: [infoObject.category.color, .white], startPoint: .top, endPoint: .bottom)
                                        Color.clear
                                            .background(.ultraThinMaterial)
                                        ContentUnavailableView(
                                            "Image",
                                            systemImage: "photo.fill",
                                            description: Text("No image selected"))
                                        .onTapGesture {
                                            //                                        isPhotoPickerPresented.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        
                        .frame(width: width, height: width)
                        .ignoresSafeArea()
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
                            
                            
                            Text(infoObject.comment ?? "")
                                .foregroundStyle(.black)
                                .font(.title3)
                        }
                        .padding(.horizontal)
                        
                        TagsView(tags: infoObject.tags)
                            .padding(.horizontal)
                        
                    }
                    
                } else {
                    if let uiimage = infoObject.image {
                        Image(uiImage: uiimage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(color: .black.opacity(0.27), radius: 10, x: 0, y: 5)
                            .onTapGesture {
                                imageIsClicked.toggle()
                            }
                    }
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
                            .foregroundStyle(infoObject.category.color)
                            .font(.title3)
                    }
                }
                ToolbarItem {
                    Button {
                        isEditing.toggle()
                    } label: {
//                        Text("Edit")
                        Image(systemName: "pencil")
                            .font(.title3)
                            .foregroundStyle(.black)
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
                .foregroundColor(.black)
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
    @Environment(\.openURL) var openURL
    var body: some View {
        Button {
            if let urlString = infoObject.stringURL,
               let url = URL(
                string: urlString
               )
            {
                openURL(url)
            }
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
