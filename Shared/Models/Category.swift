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

    // Computed property to use the SwiftUI Color
    
    @Transient
    var color: Color {
        Color.named(colorName)
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

extension Color {
    static func named(_ name: String) -> Color {
        switch name.lowercased() {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        case "pink": return .pink
        case "purple": return .purple
        case "yellow": return .yellow
        case "teal": return .teal
        case "indigo": return .indigo
        case "cyan": return .cyan
        case "mint": return .mint
        case "brown": return .brown
        case "gray": return .gray
        default: return .gray
        }
    }
}
