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
    let infoObject: InfoObject?
    
    @State private var uiImage: UIImage? = nil
    @State private var title: String = ""
    @State private var stringURL: String = ""
    @State private var selectedCategory: Category? = Category(name: "No Category", colorName: "gray", iconName: "questionmark")
    @State private var comment: String = ""
    
    
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
                Color.black.opacity(0.05).ignoresSafeArea()
            }
            .navigationTitle(isEditing ? "Edit Item" : "Add Item")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Save" : "Add") {
                        withAnimation(.snappy) {
                            save()
                            dismiss()
                        }
                    }
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
            }
        }
        
        
    }
    
    private var titleForm: some View {
        // TITLE
        VStack(alignment: .leading) {
            Text("TITLE")
                .font(.footnote)
                .foregroundStyle(.black.opacity(0.5))
                .padding(.top, 8)
                .padding(.horizontal, 12)
            TextField("Add Title", text: $title)
            //                                .textFieldStyle(.roundedBorder)
                .font(.title3)
                .padding(8)
                .padding(.horizontal, 4)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                }
        }
        .padding(.horizontal, 16)
    }
    
    private var categoryForm: some View {
        VStack(alignment: .leading) {
            Text("CATEGORY")
                .font(.footnote)
                .foregroundStyle(.black.opacity(0.5))
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
                    .foregroundStyle(.black)
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
                    .fill(.white)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var linkForm: some View {
        VStack(alignment: .leading) {
            Text("LINK")
                .font(.footnote)
                .foregroundStyle(.black.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            TextField("Add Link", text: $stringURL)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                }
        }
        .padding(.horizontal, 16)
    }
    
    private var commentForm: some View {
        VStack(alignment: .leading) {
            Text("COMMENT")
                .font(.footnote)
                .foregroundStyle(.black.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            TextField("Add Comment", text: $comment, axis: .vertical)
                .padding(12)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
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
                comment: comment
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
    
    /*
    //    @ViewBuilder
    //    func formView(infoObject: InfoObject) -> some View {
    //        Form {
    //            if let uiImage = infoObject.image {
    //                Image(uiImage: uiImage)
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(maxHeight: 200)
    //                    .clipShape(RoundedRectangle(cornerRadius: 10))
    //                    .onTapGesture {
    //                        isPhotoPickerPresented.toggle()
    //                    }
    //
    //            }
    //
    //            //MARK: Image section
    //            Section("Image") {
    //                VStack {
    //                    if let uiImage = infoObject.image {
    //                        Image(uiImage: uiImage)
    //                            .resizable()
    //                            .scaledToFit()
    //                            .frame(maxHeight: 200)
    //                            .clipShape(RoundedRectangle(cornerRadius: 10))
    //                            .onTapGesture {
    //                                isPhotoPickerPresented.toggle()
    //                            }
    //                    } else {
    //                        ContentUnavailableView(
    //                            "No picture",
    //                            systemImage: "photo.fill",
    //                            description: Text("No image selected"))
    //                        .onTapGesture {
    //                            isPhotoPickerPresented.toggle()
    //                        }
    //                    }
    //                }
    //                .sheet(isPresented: $isPhotoPickerPresented) {
    //                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
    //                        .photosPickerStyle(.inline)
    //                        .photosPickerDisabledCapabilities([.collectionNavigation, .search])
    //                        .presentationDetents([.medium, .large])
    //                        .presentationBackground(.clear)
    //                        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    //
    //
    //                }
    //                .onChange(of: selectedPhotoItem) { _, _ in
    //                    loadImage()
    //                }
    //
    //            }
    //            //MARK: Title field
    //            Section("Title") {
    //                if let title = Binding($infoObject.title) {
    //                    TextField("", text: title)
    //                        .bold()
    //                        .font(.title3)
    //
    //                }
    //            }
    //
    //            //MARK: Category field with Menu
    //            Section("Category") {
    //                MenuCategory(categories: infoObjects.findUniqueCategories(), infoObject: infoObject)
    //
    //                Button {
    //                    isCreateCategorySheetPresented.toggle()
    //                } label: {
    //                    HStack {
    //                        Image(systemName: "plus.circle")
    //                        Text("Add New")
    //
    //                    }
    //                }
    //                .sheet(isPresented: $isCreateCategorySheetPresented) {
    //                    CreateCategorySheetView(infoObject: infoObject, category: Category(name: "No Category", colorName: "gray", iconName: "questionmark"))
    //                }
    //            }
    //
    //            //MARK: Link section
    //            Section("Link") {
    //                if let stringURL = Binding($infoObject.stringURL) {
    //
    //                    TextField("", text: stringURL)
    //                }
    //            }
    //
    //            //MARK: Comment field
    //            Section("Comment") {
    //                if let comment = Binding($infoObject.comment) {
    //
    //                    TextField("", text: comment)
    //                }
    //            }
    //
    //            //MARK: Tags field
    //            //                Section("Tags") {
    //            //                    Button {
    //            //                        isTagsPickerPresented.toggle()
    //            //                    } label: {
    //            //                        HStack {
    //            //                            Image(systemName: "plus.circle")
    //            //                            Text("Add a tag")
    //            //                            // Label(systemImage: "plus.circle.fill")
    //            //                        }
    //            //                    }
    //            //                    .sheet(isPresented: $isTagsPickerPresented) {
    //            //                        NavigationStack {
    //            //                            VStack {
    //            //                                Text("Add a tag")
    //            //                                    .font(.title)
    //            //                                    .bold()
    //            //
    //            //                                TextField("Tag", text: $tagNewItem)
    //            //                                    .padding(.horizontal, 180)
    //            //                            }
    //            //                        }
    //            //                        .presentationDetents([.medium])
    //            //                         .presentationDragIndicator(.visible)
    //            //                    }
    //            //                }
    //
    //
    //        }
    //    }
    
     */
    @ViewBuilder
    func ImagePickerView() -> some View {
        let width = UIScreen.main.bounds.width
        
        ZStack {
            // BG IMAGE
            if let uiimage = uiImage {
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
                if let uiimage = uiImage {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: width * 0.8, maxHeight: width * 0.65)
                        .shadow(color: .black.opacity(0.27), radius: 10, x: 0, y: 5)
                        .onTapGesture {
                            isPhotoPickerPresented.toggle()
                        }
                } else {
                    ZStack {
                        LinearGradient(colors: [selectedCategory?.color ?? .gray, .white], startPoint: .top, endPoint: .bottom)
                        Color.clear
                            .background(.ultraThinMaterial)
                        ContentUnavailableView(
                            "Image",
                            systemImage: "photo.fill",
                            description: Text("No image selected"))
                        .onTapGesture {
                            isPhotoPickerPresented.toggle()
                        }
                    }
                }
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
            }
    }
    
}

#Preview {
    AddItemView(
        infoObject: nil,
        isEditing: false,
        infoObjects: []
    )
}


struct MenuCategory: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
    var body: some View {
        Menu {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    Label(category.name.capitalized, systemImage: category.iconName)
                        .tint(category.color)
                }
            }
            
        } label: {
            HStack {
                Image(systemName: selectedCategory?.iconName ?? Category.noCategory.iconName)
                    .foregroundStyle(selectedCategory?.color ?? Category.noCategory.color)
                
                
                Text(selectedCategory?.name ?? Category.noCategory.name)
                    .foregroundStyle(.black)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
                
                
            }
        }
        
        
    }
}

