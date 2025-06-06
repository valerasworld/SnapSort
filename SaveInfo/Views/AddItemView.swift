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
    @Bindable var infoObject: InfoObject
    @State var isPhotoPickerPresented: Bool = false
    @State var selectedPhotoItem: PhotosPickerItem?
    @State var isCreateCategorySheetPresented: Bool = false
    @State var isEditing: Bool
    var infoObjects: [InfoObject]

    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

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
                        PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
                            .photosPickerStyle(.inline)
                            .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                            .presentationDetents([.medium, .large])
                            .presentationBackground(.clear)
                            .presentationBackgroundInteraction(.enabled(upThrough: .large))
                        

                    }
                    .onChange(of: selectedPhotoItem) { _, _ in
                        loadImage()
                    }

                 }
                //MARK: Title field
                Section("Title") {
                    if let title = Binding($infoObject.title) {
                        TextField("", text: title)
                            .bold()
                            .font(.title3)

                    }
}
                
                //MARK: Category field with Menu
                Section("Category") {
                    MenuCategory(categories: infoObjects.findUniqueCategories(), isPresented: $isCreateCategorySheetPresented, infoObject: infoObject)
                    Button {
                        isCreateCategorySheetPresented.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add New")
                        }
                    }
                    .sheet(isPresented: $isCreateCategorySheetPresented) {
                        CreateCategorySheetView(infoObject: infoObject, category: Category(name: "No Category", colorName: "gray", iconName: "questionmark"))
                    }
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
                        if isEditing {
                            dismiss()
                        } else {
                            modelContext.insert(infoObject)
                            dismiss()
                        }
                        
                    }
                }
            }
        
            
        }
        
    }
    func loadImage() {
        Task {
            guard let selectedPhotoItem,
                  let data = try? await selectedPhotoItem.loadTransferable(type: Data.self),
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
            dateAdded: .now,
            comment: "",
        ),
        isEditing: false,
        infoObjects: []
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
    @Binding var isPresented: Bool
    var infoObject: InfoObject
    var body: some View {
        Menu {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    infoObject.category = category
                }) {
                    Label(category.name.capitalized, systemImage: category.iconName)
                        .tint(category.color)
                }
            }
            
        } label: {
            HStack {
                Image(systemName: infoObject.category.iconName)
                    .foregroundStyle(infoObject.category.color)
                
                
                Text(infoObject.category.name)
                    .foregroundStyle(infoObject.category.color)
                
            }
        }
        
        
    }
}

