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
    //MARK: grab items from the Models: infoObject, category
//    let infoObject: InfoObject
//    @Binding var userData: UserDataManager
    
//    MARK: Set the items to add
//    @State var titleNewItem: String
//    @State var imageNewItem: Image?
//    @State var selectedCategory: Category?
    @State var selectedItem: PhotosPickerItem?
//    @State var tagNewItem: String
//    @State var linkNewItem: String
//    @State var commentNewItem: String

    //MARK: Wrappers for Modals: showModal (for adding a new category) and isPresented, isPhotoPickerPresented for the Photo Picker modal.
//    @Binding var showModal: Bool
//    @State var isPresented: Bool = false
    @State var isPhotoPickerPresented: Bool = false
    @State var isTagsPickerPresented: Bool = false
    
//MARK: For the PhotoPicker
//    @State private var filterIntensity = 0.5
//    @State var currentFilter = CIFilter.sepiaTone()
//    let context = CIContext()
    
//    @Query var infoObjects: [InfoObject]
    @Bindable var infoObject: InfoObject
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            Form {
                
                //MARK: Image section
                Section("Image") {
                    VStack {
                        if let uiImage = infoObject.image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    isPhotoPickerPresented.toggle()
                                }
                        } else {
                            ContentUnavailableView(
                                "No picture",
                                systemImage: "photo.fill",
                                description: Text("No image selected"))
                            .onTapGesture {
                                isPhotoPickerPresented.toggle()
                            }
                        }
                    }
//                    VStack {
//
//                                ContentUnavailableView(
//                                    "No picture",
//                                    systemImage: "photo.fill", description: Text("No image selected"))
//                                .onTapGesture {
//                                    isPhotoPickerPresented.toggle()
//                                }
//
//                            }
//
                    .sheet(isPresented: $isPhotoPickerPresented) {
                        PhotosPicker(selection: $selectedItem, matching: .images) { }
                            .photosPickerStyle(.inline)
                            .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                            .presentationDetents([.medium, .large])
                            .presentationBackground(.clear)
                            .presentationBackgroundInteraction(.enabled(upThrough: .large))
                        

                    }
                    .onChange(of: selectedItem) { _ in
                        loadImage()
                    }

                 }
                //MARK: Title field
                Section("Title") {
                    if let title = Binding($infoObject.title) {
                        TextField("", text: title)
                            .bold()
                            .font(.title)

                    }
}
                
                //MARK: Category field with Menu
                Section("Category") {
//                    MenuCategory(categories: infoObjects.findUniqueCategories(), selectedCategory: $selectedCategory, isPresented: $isPresented)
                    // CategoryPicker(category: Category.allCases, selectedCategory: $selectedCategory)
//                    Button {
//                        isPresented.toggle()
//                    } label: {
//                        HStack {
//                            Image(systemName: "plus.circle")
//                            Text("Add New")
//                        }
//                        }
                    }
                
                //MARK: Link section
                Section("Link") {
                    if let stringURL = Binding($infoObject.stringURL) {
                        
                        TextField("", text: stringURL)
                    }
                }
                
                //MARK: Comment field
                Section("Comment") {
                    if let comment = Binding($infoObject.comment) {
                        
                        TextField("", text: comment)
                    }
                }
                
                //MARK: Tags field
//                Section("Tags") {
//                    Button {
//                        isTagsPickerPresented.toggle()
//                    } label: {
//                        HStack {
//                            Image(systemName: "plus.circle")
//                            Text("Add a tag")
//                            // Label(systemImage: "plus.circle.fill")
//                        }
//                    }
//                    .sheet(isPresented: $isTagsPickerPresented) {
//                        NavigationStack {
//                            VStack {
//                                Text("Add a tag")
//                                    .font(.title)
//                                    .bold()
//                                
//                                TextField("Tag", text: $tagNewItem)
//                                    .padding(.horizontal, 180)
//                            }
////                            .toolbar {
////                                ToolbarItem(placement: .topBarTrailing) {
////                                    Button("Add") {
////                                        // logic to add tags
////                                    }
////                                }
////                            }
//                        }
//                        .presentationDetents([.medium])
//                        .presentationDragIndicator(.visible)
//                    }
//                }

                
            }
            .navigationTitle("Add an Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
//                        showModal = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
//                        showModal = false

                        modelContext.insert(infoObject)
                    }
                }
            }
        
            
        }
        
    }
    func loadImage() {
        Task {
            guard let selectedItem,
                  let data = try? await selectedItem.loadTransferable(type: Data.self),
                  let uiImage = UIImage(data: data) else {
                return
            }
            infoObject.image = uiImage
        }
    }
}

#Preview {
    AddItemView(
        infoObject: InfoObject(
            title: "",
            stringURL: "",
            tags: [],
            category: Category(
                name: "No Category",
                colorName: "gray",
                iconName: "questionMark"
            ),
            comment: "",
        )
    )
}

struct CategoryPicker: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Picker(
                selection: $selectedCategory,
                label:
                    HStack {
//                        Image(
//                            systemName: selectedCategory?.iconName ?? ""
//                        )
//                        .tint(
//                            selectedCategory?.color ?? .gray
//                        )
                        
                        Text(
                            selectedCategory != nil ? "Category" : "Select category"
                        )
//                        .foregroundStyle(selectedCategory?.color ?? .gray)
                        
                    }) {
                        ForEach(
                            categories,
                            id: \.self
                        ) { category in
                            HStack {
                                Image(systemName: category.iconName)
                                    .tint(category.color)
                                
                                Text(category.name)
                                    .foregroundStyle(.secondary)
                            }
                            .tint(category.color)
                            .tag(Optional(category))
                        }
                    }
                    .pickerStyle(.menu)
        }
    }
}


struct MenuCategory: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
    @Binding var isPresented: Bool
    @State var newCategory: String = ""
    @State private var bgColor =
           Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
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
                if let selectedCategory = selectedCategory {
                    Image(systemName: selectedCategory.iconName)
                        .foregroundStyle(selectedCategory.color)
                }
                
                Text(selectedCategory?.name ?? "Select Category")
                    .foregroundStyle(selectedCategory != nil ? .black : .gray)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack(alignment: .leading) {
                Text("Add New Category")
                    .font(.title3)
                    .bold()
                TextField("New Category Name", text: $newCategory)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                
                ColorPicker("Choose a color :)", selection: $bgColor)
                
            }
            .padding()
            
        }
        
    }
}

