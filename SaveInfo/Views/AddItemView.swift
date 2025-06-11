//
//  AddItemView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 24/05/25.
//

// As the name, this view will let the user add an item.
// The view should be composed by the following fields:
// * Photo of the item (optional)
// * Title of the item
// * Link of the item
// * Description of the item (optional)
// * Tags of the item
// * Category of the item (and the feature of adding a new one)

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

import SwiftData

struct AddItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    let infoObject: InfoObject?
    
    @State private var uiImage: UIImage? = nil
    @State private var title: String = ""
    @State private var stringURL: String = ""
    @State private var selectedCategory: Category? = Category(name: "No Category", colorName: "gray", iconName: "questionmark")
    @State private var comment: String = ""
    @State private var hasImageFromLibrary: Bool = false
    @State private var hasUsersTitle: Bool = false
    
    @State var isPhotoPickerPresented: Bool = false
    @State var selectedPhotoItem: PhotosPickerItem?
    @State var isCreateCategorySheetPresented: Bool = false
    @State var isEditing: Bool
    var infoObjects: [InfoObject]
    
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ZStack(alignment: .bottom) {
                        ImagePickerView()
                        Divider()
                    }
                    
                    // TITLE
                    titleForm
                    
                    // CATEGORY
                    categoryForm
                    
                    // LINK
                    linkForm
                    
                    // COMMENT
                    commentForm
                    
                }
                
            }
            .background {
                if colorScheme == .light {
                    Color.black.opacity(0.05)
                        .ignoresSafeArea()
                } else {
                    Color(#colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183909252, alpha: 1))
                        .ignoresSafeArea()
                }
                    
            }
            .navigationTitle(isEditing ? "Edit Item" : "Add Item")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(colorScheme == .light ? .black : .white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Save" : "Add") {
                        withAnimation(.snappy) {
                            save()
                            dismiss()
                        }
                    }
                    .foregroundStyle(colorScheme == .light ? .black : .white)
                }
            }
        }
        
        .onAppear {
            if let infoObject {
                title = infoObject.title ?? ""
                selectedCategory = infoObject.category
                stringURL = infoObject.stringURL ?? ""
                comment = infoObject.comment ?? ""
                uiImage = infoObject.image
                hasImageFromLibrary = infoObject.hasImageFromLibrary
                hasUsersTitle = infoObject.hasUsersTitle
            }
        }
        
        
    }
    
    private var titleForm: some View {
        // TITLE
        VStack(alignment: .leading) {
            Text("TITLE")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 8)
                .padding(.horizontal, 12)
            TextField("Add Title", text: $title)
                .font(.title3)
                .padding(8)
                .padding(.horizontal, 4)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
                .onChange(of: title) { _, newValue in
                        if newValue != infoObject?.title {
                            infoObject?.hasUsersTitle = true
                        }
                    }
        }
        .padding(.horizontal, 16)
    }
    
    private var categoryForm: some View {
        VStack(alignment: .leading) {
            Text("CATEGORY")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            VStack(alignment: .leading) {
                let userCategories = infoObjects.findUniqueCategories()
                if !userCategories.isEmpty {
                    MenuCategory(
                        categories: infoObjects.findUniqueCategories(),
                        selectedCategory: $selectedCategory
                    )
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                    Divider()
                        .padding(.horizontal, 12)
                }
                
                Button {
                    isCreateCategorySheetPresented.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add New")
                        
                    }
                    .foregroundStyle(colorScheme == .light ? .black : .white)
                }
                .padding(.horizontal, 12)
                .padding(.top, !userCategories.isEmpty ? 6 : 12)
                .padding(.bottom, 12)
                .sheet(isPresented: $isCreateCategorySheetPresented) {
                    CreateCategorySheetView(selectedCategory: $selectedCategory)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var linkForm: some View {
        VStack(alignment: .leading) {
            Text("LINK")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            TextField("Add Link", text: $stringURL)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
        }
        .padding(.horizontal, 16)
    }
    
    private var commentForm: some View {
        VStack(alignment: .leading) {
            Text("COMMENT")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            TextField("Add Comment", text: $comment, axis: .vertical)
                .padding(12)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
            
        }
        .padding(.horizontal, 16)
    }
    
    private func save() {
        if let infoObject {
            // Edit the infoObject
            infoObject.title = title
            infoObject.category = selectedCategory ?? .noCategory
            infoObject.stringURL = stringURL
            infoObject.comment = comment
            infoObject.hasImageFromLibrary = hasImageFromLibrary
            infoObject.hasUsersTitle = hasUsersTitle
            
            if let uiImage {
                infoObject.image = uiImage
            }
        } else {
            // Add an infoObject
            let newInfoObject = InfoObject(
                title: title,
                stringURL: stringURL,
                tags: [], // CHANGE CHANGE IN THE FUTURE
                category: selectedCategory ?? .noCategory,
                dateAdded: .now,
                comment: comment,
                hasImageFromLibrary: hasImageFromLibrary,
                hasUsersTitle: title != "" ? true : false
            )
            
            if let uiImage {
                newInfoObject.image = uiImage
            }
            
            modelContext.insert(newInfoObject)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    @ViewBuilder
    func ImagePickerView() -> some View {
        let width = UIScreen.main.bounds.width
        ZStack(alignment: .bottom) {
            ZStack {
                // BG IMAGE
                if let uiimage = uiImage {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(1/1, contentMode: .fill)
                        .frame(maxWidth: width, maxHeight: width)
                        .clipped()
                    
                    LinearGradient(colors: [(colorScheme == .light ? .white : .black), .clear, . clear], startPoint: .bottom, endPoint: .top)
                }
                
                Color.clear
                    .background(.ultraThinMaterial)
                
                ZStack {
                    if let uiimage = uiImage {
                        Image(uiImage: uiimage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(maxWidth: width * 0.8, maxHeight: width * 0.65)
                            .shadow(color: .black.opacity(0.27), radius: 10, x: 0, y: 5)
                            
                    } else {
                        ZStack {
                            LinearGradient(colors: [selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? .gray, (colorScheme == .light ? .white : .black)], startPoint: .top, endPoint: .bottom)
                            Color.clear
                                .background(.ultraThinMaterial)
                            ContentUnavailableView(
                                "Add Image",
                                systemImage: "plus",
                                description: Text("No Image here yet"))
                            .onTapGesture {
                                isPhotoPickerPresented.toggle()
                            }
                        }
                    }
                }
            }
            if let _ = uiImage {
                Button {
                    isPhotoPickerPresented.toggle()
                } label : {
                    Label {
                        Text("Add New Image")
                            .font(.title3)
                    } icon: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
//                            .background {
//                                Circle()
//                                    .fill(colorScheme == .light ? .white : .black)
//                                    .padding(2)
//                            }
                    }
                    .bold()
//                    .foregroundStyle(Color.named(selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme))
                    .foregroundStyle((selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? infoObject?.category.color(for: userData.colorTheme, colorScheme: colorScheme)) ?? Category.noCategory.color(for: userData.colorTheme, colorScheme: colorScheme))
                }
                .padding(.bottom, 20)
                
            }
            
        }
        
        .frame(width: width, height: width)
        .ignoresSafeArea()
        
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
                .photosPickerStyle(.inline)
                .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
            
            
        }
        .onChange(of: selectedPhotoItem) {
            Task {
                await loadImage()
                hasImageFromLibrary = true
                
            }
        }
    }
    
    func loadImage() async {
        guard let selectedPhotoItem,
                  let data = try? await selectedPhotoItem.loadTransferable(type: Data.self),
                  let loadedImage = UIImage(data: data) else {
                return
            }
            
            // Update the @State so the UI refreshes
            await MainActor.run {
                uiImage = loadedImage
                infoObject?.image = loadedImage
                infoObject?.hasImageFromLibrary = true
            }
    }
    
}

#Preview {
    
    let (container, userDataManager) = previewBigContainer()
    
    AddItemView(
            infoObject: nil,
            isEditing: false,
            infoObjects: []
        )
        .modelContainer(container)
        .environment(userDataManager)
    
}


struct MenuCategory: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    let categories: [Category]
    @Binding var selectedCategory: Category?
    var body: some View {
        Menu {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    Label(category.name.capitalized, systemImage: category.iconName)
                        .tint(category.color(for: userData.colorTheme, colorScheme: colorScheme))
                }
            }
            
        } label: {
            HStack {
                Image(systemName: selectedCategory?.iconName ?? Category.noCategory.iconName)
                    .foregroundStyle(selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? Category.noCategory.color(for: userData.colorTheme, colorScheme: colorScheme))
                
                
                Text(selectedCategory?.name ?? Category.noCategory.name)
                    .foregroundStyle((colorScheme == .light ? .black : .white))
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
                
                
            }
        }
        
        
    }
}

