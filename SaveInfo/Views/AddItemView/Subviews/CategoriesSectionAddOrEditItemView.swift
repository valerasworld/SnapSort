//
//  CategoriesSectionAddOrEditItemView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct CategoriesSectionAddOrEditItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var userCategories: [Category]
    @Binding var viewModel: AddOrEditItemViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("CATEGORY")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            VStack(alignment: .leading) {
                if userCategories.isEmpty {
                    if let selectedCategory = viewModel.selectedCategory {
                        CategoriesMenuLabel(selectedCategory: selectedCategory)
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                            .padding(.bottom, 6)
                        Divider()
                            .padding(.horizontal, 12)
                    }
                } else {
                    CategoriesMenu(
                        categories: userCategories,
                        selectedCategory: $viewModel.selectedCategory
                    )
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                    
                    Divider()
                        .padding(.horizontal, 12)
                }
                
                
                AddNewCategoryButton(
                    userCategories: userCategories,
                    isCreateCategorySheetPresented: $viewModel.isCreateCategorySheetPresented,
                    selectedCategory: $viewModel.selectedCategory
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CategoriesSectionAddOrEditItemView(userCategories: [], viewModel: .constant(AddOrEditItemViewModel()))
}
