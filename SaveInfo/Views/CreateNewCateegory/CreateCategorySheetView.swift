////
////  AddOrEditView.swift
////  SaveInfo
////
////  Created by Valery Zazulin on 03/06/25.
////

import Foundation
import SwiftUI
import SwiftData

@Observable
class CreateCategoryViewModel {
    
    var sheetHeight: CGFloat = .zero
    
    var newCategoryName: String = ""
    var selectedColorName: String = "gray"
    var selectedIconName: String = "questionmark"
}

struct CreateCategorySheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
            
    @Environment(\.dismiss) var dismiss
    
    @FocusState var categoryNameInFocus: Bool
    
    @Binding var selectedCategory: Category?
    
    @State var viewModel = CreateCategoryViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack {
                VStack(spacing: 16) {
                    CreateNewCategorySheetHeaderView()
                    
                    CustomColorPickerView(selectedColorName: $viewModel.selectedColorName)
                        .padding(.top, 20)
                    
                    Divider()
                        .padding(.vertical, 4)
                                     
                    IconPickerView(selectedIconName: $viewModel.selectedIconName, selectedCategoryColorName: $viewModel.selectedColorName)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    CategoryNameTextFieldView(newCategoryName: $viewModel.newCategoryName)
                }
                .padding(.vertical, 6)
            }
            .compositingGroup()
            
            CreateNewCategoryButton(viewModel: $viewModel, selectedCategory: $selectedCategory)
            
        }
        .padding(20)
        .modifier(GetHeightModifier(height: $viewModel.sheetHeight))
        .presentationDetents([.height(viewModel.sheetHeight)])
        .background(RemoveSheetBackground())
    }
    
    
}

#Preview {
    let (container, userDataManager) = previewContainer(size: .empty)
    CreateCategorySheetView(selectedCategory: .constant(.noCategory))
        .environment(userDataManager)
        .modelContainer(container)
}

