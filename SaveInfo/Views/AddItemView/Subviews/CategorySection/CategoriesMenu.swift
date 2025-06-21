//
//  CategoriesMenu.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct CategoriesMenu: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    @Environment(\.uniqueCategories) var uniqueCategories
    
    @Binding var selectedCategory: Category?
    
    var body: some View {
        Menu {
            ForEach(uniqueCategories, id: \.self) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Label(category.name.capitalized, systemImage: category.iconName)
                        .tint(category.color(for: userData.colorTheme, colorScheme: colorScheme))
                }
            }
        } label: {
            CategoriesMenuLabel(selectedCategory: selectedCategory)
        }
    }
}


struct CategoriesMenuLabel: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var selectedCategory: Category?
    var isInMenu: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: selectedCategory?.iconName ?? Category.noCategory.iconName)
                .foregroundStyle(selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? Category.noCategory.color(for: userData.colorTheme, colorScheme: colorScheme))
            
            
            Text(selectedCategory?.name ?? Category.noCategory.name)
                .foregroundStyle((colorScheme == .light ? .black : .white))
            
            if isInMenu {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
            }
            
        }
        
    }
}

#Preview {
    CategoriesMenu(selectedCategory: .constant(nil))
}
