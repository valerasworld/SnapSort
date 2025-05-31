//
//  UsersCategory.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 29/05/25.
//

import SwiftUI
import SwiftData

@Model
class UsersCategory: Identifiable, Hashable {
    var id: UUID
    var name: String
    var colorName: String // Store only the name of the color
    var iconName: String

    init(id: UUID = UUID(), name: String, colorName: String, iconName: String) {
        self.id = id
        self.name = name
        self.colorName = colorName
        self.iconName = iconName
    }

    // Computed property to use the SwiftUI Color
    @Transient
    var color: Color {
        Color.named(colorName)
    }

    // Hashable
    static func == (lhs: UsersCategory, rhs: UsersCategory) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
