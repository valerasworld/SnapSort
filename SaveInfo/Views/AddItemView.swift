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

struct AddItemView: View {
    //MARK: grab items from the Models: infoObject, category
    let infoObject: InfoObject
    let category: Category.AllCases
    @Binding var userData: UserDataManager
    
//    MARK: Set the items to add
    @State var titleNewItem: String
    @State var imageNewItem: Image?
    @State var descriptionNewItem: String
    @State var selectedCategory: Category?
    @State var selectedItem: PhotosPickerItem?
    //    @State var tagNewItem: String

    //MARK: Wrappers for Modals: showModal (for adding a new category) and isPresented, isPhotoPickerPresented for the Photo Picker modal.
    @Binding var showModal: Bool
    @State var isPresented: Bool = false
    @State var isPhotoPickerPresented: Bool = false
    
//MARK: For the PhotoPicker
    @State private var filterIntensity = 0.5
    @State var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            Form {
//                ---
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
//                        }
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
                
                //MARK: Description field
                Section("Description") {
                    TextEditor(text: $descriptionNewItem)
                        .font(.title3)
                }
                
                //MARK: Tags field
                Section("Tags") {
                    Button("Add tag +") {
                        // Label(systemImage: "plus.circle.fill")
                    }
                }
                //MARK: Category field with Menu
                Section("Category") {
                    MenuCategory(category: Category.allCases, selectedCategory: $selectedCategory, isPresented: $isPresented)
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
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showModal = false
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let newObject = InfoObject(
                                id: UUID().uuidString,
                                title: titleNewItem,
                                description: descriptionNewItem,
                                author: nil,
                                image: nil,
                                genre: nil,
                                stringURL: nil,
                                tags: [],
                                category: selectedCategory ?? Category.allCases.first!,
                                dateAdded: Date.now,
                                completed: nil,
                                comment: nil,
                                previewLoading: false,
                                linkMetaData: nil,
                                linkURL: nil
                            )

                            if userData.useMockData {
                                userData.mockData.append(newObject)
                            } else {
                                userData.liveObjects.append(newObject)
                            }

                    }
                }
            }
            .navigationTitle("Add an Item")
            .navigationBarTitleDisplayMode(.inline)
        
            
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
    
//    func applyProcessing() {
//        currentFilter.intensity = Float(filterIntensity)
//        guard let outputImage = currentFilter.outputImage else { return }
//        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
//        
//        let uiImage = UIImage(cgImage: cgImage)
//        
//    }
}

#Preview {
    @Previewable
    @State var infoObject2 = InfoObject(
        title: "Harry Potter",
        description: "Renata is the best actress of the Moscow Art Theater",
        author: "J.K. Rowling",
        stringURL: "https://t.me/renatalitvinova/5500",
        tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"],
        category: .restaurants,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 1))!)
    
    AddItemView(infoObject: infoObject2, category: Category.allCases, userData: .constant(UserDataManager()), titleNewItem: "", descriptionNewItem: "", showModal: .constant(true))
}

struct CategoryPicker: View {
    let category: Category.AllCases
    @Binding var selectedCategory: Category?
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Picker(
                selection: $selectedCategory,
                label:
                    HStack {
                        //                    Image(
                        //                        systemName: selectedCategory?.iconName ?? ""
                        //                    )
                        //                    .tint(
                        //                        selectedCategory?.color ?? .gray
                        //                    )
                        
                        Text(
                            selectedCategory != nil ? "Category" : "Select category"
                        )
                        //.foregroundStyle(selectedCategory?.color ?? .gray)
                        
                    }) {
                        ForEach(
                            Category.allCases,
                            id: \.self
                        ) { category in
                            HStack {
                                Image(systemName: category.iconName)
                                    .tint(category.color)
                                
                                Text(category.rawValue.capitalized)
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
    let category: Category.AllCases
    @Binding var selectedCategory: Category?
    @Binding var isPresented: Bool
    
    var body: some View {
        Menu {
            ForEach(Category.allCases, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                }) {
                    Label(category.rawValue.capitalized, systemImage: category.iconName)
                        .tint(category.color)
                }
            }
            
        } label: {
            HStack {
                if let selectedCategory = selectedCategory {
                    Image(systemName: selectedCategory.iconName)
                        .foregroundStyle(selectedCategory.color)
                }
                
                Text(selectedCategory?.rawValue.capitalized ?? "Select Category")
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
                TextField("New Category Name", text: .constant(""))
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .padding()
            
        }
        
    }
}

