//
//  CategoryButtonLabel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 20/06/25.
//
import SwiftUI

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
