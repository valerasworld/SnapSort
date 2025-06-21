//
//  CategoriesFilterView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI

struct CategoriesFilterView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.uniqueCategories) var uniqueCategories
        
    @Binding var selectedCategories: [Category]
    
    var body: some View {
        HStack {
            ForEach(uniqueCategories.sortByColor(), id: \.self) { category in
                CategoryButtonView(category: category, selectedCategories: $selectedCategories)
            }
        }
        .padding(.bottom, 12)
        .padding(.horizontal, 16)
    }
}

struct CategoryButtonView: View {
        
    var category: Category
    
    @Binding var selectedCategories: [Category]
    
    var isSelected: Bool {
        selectedCategories.contains(category)
    }
    
    var body: some View {
        Button {
            withAnimation(.snappy) {
                if isSelected {
                    selectedCategories.removeAll { $0 == category }
                } else {
                    selectedCategories.append(category)
                }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        } label : {
            CategoryButtonLabel(category: category, isSelected: isSelected)
        }
        .buttonStyle(.plain)
    }
}


