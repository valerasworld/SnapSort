//
//  IconPickerLabel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//


import SwiftUI

struct IconPickerLabel: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var iconName: String
    @Binding var selectedIconName: String
    @Binding var selectedCategoryColorName: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(colorScheme == .light ? Color.black : Color.white, lineWidth: selectedIconName == iconName ? 0 : 2.5)
                .fill(
                    selectedIconName == iconName ?
                    Color.named(selectedCategoryColorName, colorTheme: userData.colorTheme, colorScheme: colorScheme) :
                    (
                        colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1))
                    )
                )
                .scaleEffect(selectedIconName == iconName ? 1.15 : 1)
                .shadow(
                    color: (
                        colorScheme == .light ? (
                            Color.black.opacity(
                                selectedIconName == iconName ? 0.17 : 0
                            )
                        ) : (
                            Color.white.opacity(
                                selectedIconName == iconName ? 0.17 : 0
                            )
                        )
                    ),
                    radius: 2,
                    y: 2
                )
            
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(selectedIconName == iconName ?
                                 (colorScheme == .light ? .white : .black) :
                                    (colorScheme == .light ? .black : .white)
                )
                .scaleEffect(selectedIconName == iconName ? 1.15 : 1)
        }
    }
}