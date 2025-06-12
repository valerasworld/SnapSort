//
//  CategoriesFilterView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI

struct CategoriesFilterView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    
    var body: some View {
        HStack {
            ForEach(infoObjects.findUniqueCategories().sortByColor(), id: \.self) { category in
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
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var category: Category
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isSelected ? .clear : (colorScheme == .light ? .white : Color(#colorLiteral(red: 0.113725476, green: 0.113725476, blue: 0.113725476, alpha: 1))))
                .padding(isSelected ? 0 : 2)
                .background(coloredCircled)
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
                    .background(coloredCircled/*.opacity(0.7)*/)
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
    
    var coloredCircled: some View {
        ZStack {
            Circle()
                .fill(category.color(for: userData.colorTheme, colorScheme: colorScheme))
        }
    }
}
