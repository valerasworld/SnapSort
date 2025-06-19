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

    @Environment(\.dismiss) var dismiss
    
    @State var isEditItemViewPresented: Bool = false
    @State var imageIsClicked: Bool = false
    
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !imageIsClicked {
                    ZStack(alignment: .bottomLeading) {
                        let width = UIScreen.main.bounds.width
                        
                        ZStack {
                            // BG BLURRED IMAGE
                            if let uiimage = infoObject.image {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(1/1, contentMode: .fill)
                                    .frame(maxWidth: width, maxHeight: width)
                                    .clipped()
                                    
                                LinearGradient(colors: [(colorScheme == .light ? .white : .black), .clear, .clear], startPoint: .bottom, endPoint: .top)
                                Color.clear
                                    .background(.ultraThinMaterial)
                            }
                            
                            // ACTUAL IMAGE
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
                                    // CATEGORY COLOR PLACEHOLDER
                                    ZStack {
                                        LinearGradient(colors: [infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme), colorScheme == .light ? .white : .black], startPoint: .top, endPoint: .bottom)
                                        Color.clear
                                            .background(.ultraThinMaterial)
                                    }
                                    .frame(width: width, height: width / 2)
                                }
                            }
                        }
                        
                        .frame(maxWidth: width, maxHeight: width)
                        .ignoresSafeArea()
                        .onChange(of: infoObject.hasImageFromLibrary || infoObject.hasValidLink) { _, _ in
                            withAnimation(.snappy) {
                                dashboardViewModel.updateInfoTypes()
                            }
                        }
                        HStack {
                            if infoObject.stringURL != nil && infoObject.stringURL != "" {
                                LinkButtonOnDetailView(infoObject: infoObject)
                            }
                            Spacer(minLength: 0)
                            // Category Label
                            
                            Image(systemName: infoObject.category.iconName)
                                .foregroundStyle(colorScheme == .light ? .white : .black)
                            
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .font(.body)
                            .bold()
                            .background {
                                Circle()
                                    .foregroundStyle(infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme))
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(infoObject.title ?? "")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        
                        
                        Text(infoObject.comment ?? "")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
//                        TagsView(tags: infoObject.tags)
//                            .padding(.horizontal)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)
                    
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
                            .foregroundStyle(infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme))
                            .font(.title3)
                    }
                }
                ToolbarItem {
                    Button {
                        isEditItemViewPresented.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .font(.title3)
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                    }
                }
            }
            .sheet(isPresented: $isEditItemViewPresented) {
                AddOrEditItemView(infoObject: infoObject, userCategories: dashboardViewModel.findUniqueCategories())
            }
            
        }
    }
}


#Preview {
    let (container, userDataManager) = previewContainer(size: .large)

    DetailedItemView(infoObject: SampleObjects.mediumContents.first!, dashboardViewModel: DashboardViewModel())
        .modelContainer(container)
        .environment(userDataManager)
}

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
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
                .foregroundColor(colorScheme == .light ? .black : .white)
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
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
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
                    .lineLimit(1)
                    .truncationMode(.middle)
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .font(.body)
            .bold()
            .foregroundStyle(colorScheme == .light ? .white : .black)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme))
            }
            .padding()
        }
        
    }
}
