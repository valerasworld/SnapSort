//
//  Category.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI
import SwiftData

@Model
class Category: Identifiable {
    var name: String
    var colorName: String // Store only the name of the color
    var iconName: String
    
    init(name: String, colorName: String, iconName: String) {
        self.name = name
        self.colorName = colorName
        self.iconName = iconName
    }
    
    func color(for colorTheme: ColorTheme, colorScheme: ColorScheme) -> Color {
        Color.named(colorName, colorTheme: colorTheme, colorScheme: colorScheme)
    }
}

extension Category: Hashable, Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name &&
        lhs.colorName == rhs.colorName &&
        lhs.iconName == rhs.iconName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(colorName)
        hasher.combine(iconName)
    }
}

extension Category {
    static let noCategory = Category(
        name: String(localized: "No Category"),
        colorName: "gray",
        iconName: "questionmark"
    )
}

enum CategoryColor: String, CaseIterable {
    case green, mint, teal, cyan, blue, indigo, purple, pink, red, orange, yellow, brown, gray
}

extension Array where Element == Category {
    
    func sortByColor() -> [Category] {
        let colorOrder = CategoryColor.allCases
        
        return self.sorted { lhs, rhs in
            let lhsColor = CategoryColor(rawValue: lhs.colorName)
            let rhsColor = CategoryColor(rawValue: rhs.colorName)
            
            let lhsIndex = lhsColor.flatMap { colorOrder.firstIndex(of: $0) } ?? .max
            let rhsIndex = rhsColor.flatMap { colorOrder.firstIndex(of: $0) } ?? .max
            
            if lhsIndex == rhsIndex {
                return lhs.name > rhs.name
            } else {
                return lhsIndex < rhsIndex
            }
        }
    }
}



