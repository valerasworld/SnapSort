//
//  CategoriesFilterView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI

struct CategoriesFilterView: View {
    
    @Environment(\.colorScheme) var colorScheme
        
    var viewModel: DashboardViewModel
    
    var body: some View {
        HStack {
            ForEach(viewModel.findUniqueCategories().sortByColor(), id: \.self) { category in
                CategoryButtonView(category: category, viewModel: viewModel)
            }
        }
        .padding(.bottom, 12)
        .padding(.horizontal, 16)
    }
}

struct CategoryButtonView: View {
        
    var category: Category
    
    var viewModel: DashboardViewModel
    
    var isSelected: Bool {
        viewModel.selectedCategories.contains(category)
    }
    
    var body: some View {
        Button {
            withAnimation(.snappy) {
                if isSelected {
                    viewModel.selectedCategories.removeAll { $0 == category }
                } else {
                    viewModel.selectedCategories.append(category)
                }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        } label : {
            CategoryButtonLabel(category: category, isSelected: isSelected)
        }
        .buttonStyle(.plain)
    }
}

struct CategoryButtonLabel: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var category: Category
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isSelected ? .clear : (colorScheme == .light ? .white : Color(#colorLiteral(red: 0.113725476, green: 0.113725476, blue: 0.113725476, alpha: 1))))
                .padding(isSelected ? 0 : 2)
                .background {
                    Circle()
                        .fill(category.color(for: userData.colorTheme, colorScheme: colorScheme))
                }
            if isSelected {
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(colorScheme == .light ? .white : .black)
                    .fontWeight(.semibold)
                    .bold()
            } else {
                Circle()
                    .foregroundStyle(.clear)
                    .background {
                        Circle()
                            .fill(category.color(for: userData.colorTheme, colorScheme: colorScheme))
                    }
                    .mask {
                        Image(systemName: category.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .fontWeight(.semibold)
                            .bold()
                    }
            }
        }
        .frame(width: 40)
    }
}
