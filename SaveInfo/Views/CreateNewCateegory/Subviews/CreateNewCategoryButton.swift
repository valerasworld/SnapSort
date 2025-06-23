//
//  CreateNewCategoryButton.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//


import SwiftUI

struct CreateNewCategoryButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
            
    @Environment(\.dismiss) var dismiss
    
    @Binding var viewModel: CreateCategoryViewModel
    @Binding var selectedCategory: Category?
    
    var body: some View {
        Button {
            selectedCategory = Category(
                name: viewModel.newCategoryName,
                colorName: viewModel.selectedColorName,
                iconName: viewModel.selectedIconName
            )
            dismiss()
        } label: {
            buttonLabel
        }
    }
    
    var buttonLabel: some View {
        HStack {
            Text(viewModel.newCategoryName != "" ? "Create": "Create New Category")
                .fontWeight(.semibold)
            
                .padding(.vertical, 15)
                .foregroundStyle(colorScheme == .light ? .white : .black)
            if viewModel.newCategoryName != "" {
                Group {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.named(viewModel.selectedColorName, colorTheme: userData.colorTheme, colorScheme: colorScheme))
                            .padding(0)
                        
                        Image(systemName: viewModel.selectedIconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                            .foregroundStyle(colorScheme == .light ? .white : .black)
                            .fontWeight(.semibold)
                            .bold()
                    }
                    .frame(width: 35)
                    Text(viewModel.newCategoryName)
                        .fontWeight(.semibold)
                    
                        .padding(.vertical, 15)
                        .foregroundStyle(colorScheme == .light ? .white : .black)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(colorScheme == .light ? .black : .white, in: .capsule)
        .padding(.top, 15)
        .padding(.bottom, 60)
    }
}
