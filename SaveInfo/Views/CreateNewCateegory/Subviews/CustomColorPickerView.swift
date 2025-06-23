//
//  CustomColorPickerView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//


import SwiftUI

struct CustomColorPickerView: View {
    @Binding var selectedColorName: String
    private let colorNames: [String] = ["green", "mint", "teal", "cyan", "blue", "indigo", "purple", "pink", "red", "orange", "yellow", "brown", "gray"
    ]
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
        CustomHoneycombsSnakeLayout(spacing: 10) {
            ForEach(colorNames, id: \.self) { colorName in
                colorCircle(colorName: colorName)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedColorName = colorName
                        }
                    }
                
            }
        }
//            }
//        }
//        .scrollIndicators(.hidden)
//        .scrollClipDisabled()
    }
    
    func colorCircle(colorName: String) -> some View {
        let circleWidthAndHeight: CGFloat = 43
        
        return ZStack {
            Circle()
                .frame(width: circleWidthAndHeight, height: circleWidthAndHeight)
                .foregroundStyle(Category(name: "", colorName: colorName, iconName: "").color(for: userData.colorTheme, colorScheme: colorScheme))
                .scaleEffect(selectedColorName == colorName ? 1.15 : 1)
                .shadow(
                    color: .black.opacity(
                        selectedColorName == colorName ? 0.17 : 0
                    ), radius: 2, y: 2
                )
            Image(systemName: "checkmark")
                .bold()
                .foregroundStyle(colorScheme == .light ? .white : .black)
                .opacity(selectedColorName == colorName ? 1 : 0)
        }
    }
}