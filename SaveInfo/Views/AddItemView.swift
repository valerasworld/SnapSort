//
//  AddItemView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 24/05/25.
//

// As the name, this view will let the user add an item.
// Wh
import SwiftUI

struct AddItemView: View {
    let infoObject: InfoObject
    let category: Category.AllCases
    @State var titleNewItem: String
    @State var imageNewItem: UIImage?
    @State var descriptionNewItem: String
    @Binding var showModal: Bool
    //    @State var imageNewItem: UIImage
    //    @State var tagNewItem: String
    @State var selectedCategory: Category?
    @State var isPresented: Bool = false
    
    @Binding var userData: UserData
    
    var body: some View {
        NavigationView {
            Form {
                Section("Image") {
                    ZStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                        
                        
                        Button("+") {
                        }
                        
                        //                    Image(systemName: "plus")
                        // Rectangle(cornerRadius: 5)
                    }
                }
                Section("Title") {
                    TextField("", text: $titleNewItem)
                        .bold()
                        .font(.title)
                }
                Section("Description") {
                    TextEditor(text: $descriptionNewItem)
                        .font(.title3)
                }
                
                Section("Tags") {
                    Button("Add tag +") {
                        // Label(systemImage: "plus.circle.fill")
                    }
                }
                
                Section("Category") {
                    MenuCategory(category: Category.allCases, selectedCategory: $selectedCategory, isPresented: $isPresented)
                    //                    CategoryPicker(category: Category.allCases, selectedCategory: $selectedCategory)
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
                        showModal.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        userData.objects.append(
                            InfoObject(
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
                            
                        )
                    }
                }
            }
            .navigationTitle("Add an Item!")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
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
    
    AddItemView(infoObject: infoObject2, category: Category.allCases, titleNewItem: "", descriptionNewItem: "", showModal: .constant(true), userData: .constant(UserData()))
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
