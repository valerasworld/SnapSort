//
//  CategoriesFilterView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI

struct CategoriesFilterView: View {
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    
    var body: some View {
        HStack {
            ForEach(infoObjects.findUniqueCategories(), id: \.self) { category in
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
    @State var isSelected: Bool = false
    
    var body: some View {
        CategoryButtonImageLayerView(category: category, isSelected: isSelected)
        .onTapGesture {
            
//            withAnimation(.spring(duration: 0.25)) {
            withAnimation(.snappy) {
                isSelected.toggle()
                if isSelected {
                    selectedCategories.append(category)
                } else {
                    selectedCategories.removeAll { $0 == category }
                }
            }
            print(selectedCategories.first?.name ?? "")
        }
    }
}

struct CategoryButtonImageLayerView: View {
    var category: Category
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isSelected ? .clear : .white)
                .padding(isSelected ? 0 : 2)
                .background(coloredCircled)
            if isSelected {
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .bold()
            } else {
                Circle()
                    .foregroundStyle(.clear)
                    .background(coloredCircled)
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
        .frame(width: 36)
    }
    
    var coloredCircled: some View {
        ZStack {
            Circle()
                .fill(category.color)
            
            Circle()
                .fill(.ultraThinMaterial)
        }
    }
}
