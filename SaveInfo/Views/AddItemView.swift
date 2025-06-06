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
    @Binding var userData: UserDataManager
    
//    MARK: Set the items to add
    @State var titleNewItem: String
    @State var imageNewItem: Image?
    @State var selectedCategory: Category?
    @State var selectedItem: PhotosPickerItem?
    @State var tagNewItem: String

    //MARK: Wrappers for Modals: showModal (for adding a new category) and isPresented, isPhotoPickerPresented for the Photo Picker modal.
    @Binding var showModal: Bool
    @State var isPresented: Bool = false
    @State var isPhotoPickerPresented: Bool = false
    @State var isTagsPickerPresented: Bool = false
    
//MARK: For the PhotoPicker
    @State private var filterIntensity = 0.5
    @State var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @Query var infoObjects: [InfoObject]
    
    var body: some View {
        NavigationView {
            Form {
                
                //MARK: Image section
                Section("Image") {
                    VStack {
                        if let image = imageNewItem {
                            image
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
//                        }
//
//
                    .sheet(isPresented: $isPhotoPickerPresented) {
                        PhotosPicker(selection: $selectedItem, matching: .images) { }
                            .photosPickerStyle(.inline)
                            .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                            .presentationDetents([.medium, .large])
                            .presentationBackground(.clear)
                            .presentationBackgroundInteraction(.enabled(upThrough: .large))
                        

                    }
                    .onChange(of: selectedItem) { _, _ in
                        loadImage()
                    }

//                    .onChange(of: selectedItem, loadImage)

//                    ZStack {
//                        Image(systemName: "photo")
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundStyle(.gray)
//                            .frame(maxWidth: .infinity)
//
//
//                        Button("+") {
//                        }
//
//                        //                    Image(systemName: "plus")
//                        // Rectangle(cornerRadius: 5)
//                    }
                }
                //MARK: Title field
                Section("Title") {
                    TextField("", text: $titleNewItem)
                        .bold()
                        .font(.title)
                }
                
                //MARK: Detail section
                Section("Details") {
                }
                
                //MARK: Description field
//                Section("Description") {
//                    TextEditor(text: $descriptionNewItem)
//                        .font(.title3)
//                }
                
                //MARK: Tags field
                Section("Tags") {
                    Button {
                        isTagsPickerPresented.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add a tag")
                            // Label(systemImage: "plus.circle.fill")
                        }
                    }
                    .sheet(isPresented: $isTagsPickerPresented) {
                        NavigationStack {
                            VStack {
                                Text("Add a tag")
                                    .font(.title)
                                    .bold()
                                
                                TextField("Tag", text: $tagNewItem)
                                    .padding(.horizontal, 180)
                            }
//                            .toolbar {
//                                ToolbarItem(placement: .topBarTrailing) {
//                                    Button("Add") {
//                                        // logic to add tags
//                                    }
//                                }
//                            }
                        }
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
                //MARK: Category field with Menu
                Section("Category") {
                    MenuCategory(categories: infoObjects.findUniqueCategories(), selectedCategory: $selectedCategory, isPresented: $isPresented)
                    // CategoryPicker(category: Category.allCases, selectedCategory: $selectedCategory)
                    Button {
                        isPresented.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add New")
                            
                        }
                    }
                }
            }
            .navigationTitle("Add an Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showModal = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let newObject = InfoObject(
                            title: titleNewItem,
                            category: selectedCategory ?? userData.initialCategory,
                            dateAdded: .now
                        )
                        
                        if userData.useMockData {
                            userData.mockData.append(newObject)
                        } else {
                            userData.liveObjects.append(newObject)
                        }
                        
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
            imageNewItem = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    AddItemView(
        userData: .constant(UserDataManager()),
        titleNewItem: "",
        tagNewItem: "",
        showModal: .constant(true)
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

