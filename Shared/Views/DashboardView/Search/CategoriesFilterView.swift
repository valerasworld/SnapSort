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
        if uniqueCategories.count <= 7 {
            
            ZStack {
                HStack {
                    ForEach(uniqueCategories.sortByColor(), id: \.self) { category in
                        CategoryButtonView(category: category, selectedCategories: $selectedCategories)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
                .padding(.horizontal, 16)
            }
        } else {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(uniqueCategories.sortByColor(), id: \.self) { category in
                        CategoryButtonView(category: category, selectedCategories: $selectedCategories)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
        }
        // ClearButton
//        .overlay(alignment: .trailing) {
//            if !selectedCategories.isEmpty {
//                Button {
//                    withAnimation(.snappy) {
//                        selectedCategories = []
//                    }
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
//                        // Animate scale and opacity together
//                        .scaleEffect(selectedCategories.isEmpty ? 0.5 : 1)
//                        .opacity(selectedCategories.isEmpty ? 0 : 1)
//                        .animation(.snappy, value: selectedCategories)
//                }
//                // Disable button hit testing when text is empty
//                .disabled(selectedCategories.isEmpty)
//                .padding(.trailing, 20)
//            }
//        }
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


