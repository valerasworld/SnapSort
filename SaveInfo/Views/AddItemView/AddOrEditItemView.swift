//
//  AddItemView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 24/05/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddOrEditItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    let infoObject: InfoObject?

    @State var viewModel = AddOrEditItemViewModel()
    
    var isEditing: Bool {
        guard infoObject != nil else {
            return false
        }
        return true
    }
    
    var userCategories: [Category]
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ImageAreaAddOrEditItemView(
                        infoObject: infoObject,
                        selectedCategory: viewModel.selectedCategory,
                        uiImage: $viewModel.uiImage,
                        hasImageFromLibrary: $viewModel.hasImageFromLibrary
                    )
                    
                    TitleFormAddOrEditItemView(title: $viewModel.title, infoObject: infoObject)
                    
                    CategoriesSectionAddOrEditItemView(userCategories: userCategories, viewModel: $viewModel)
                    
                    LinkFormAddOrEditItemView(stringURL: $viewModel.stringURL)
                    
                    CommentFormAddOrEditItemView(comment: $viewModel.comment)
                }
            }
            .background {
                if colorScheme == .light {
                    Color.black.opacity(0.05).ignoresSafeArea()
                } else {
                    Color(#colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183909252, alpha: 1)).ignoresSafeArea()
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
                            viewModel.save(infoObject, to: modelContext)
                            dismiss()
                        }
                    }
                    .foregroundStyle(colorScheme == .light ? .black : .white)
                }
            }
        }
        .onAppear {
            viewModel.updateViewModelData(from: infoObject)
        }
    }
}

#Preview {
    let (container, userDataManager) = previewContainer(size: .large)
    
    AddOrEditItemView(
        infoObject: nil,
        userCategories: DashboardViewModel().findUniqueCategories()
    )
    .modelContainer(container)
    .environment(userDataManager)
}
