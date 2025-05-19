//
//  Category.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

enum Category: String, CaseIterable {
    case books
    case music
    case movies
    case clothes
    case restaurants
    case memes
    case electronics
    
    var color: Color {
        switch self {
        case .books:
            return .purple
        case .music:
            return .indigo
        case .movies:
            return .green
        case .clothes:
            return .green
        case .restaurants:
            return .orange
        case .memes:
            return .blue
        case .electronics:
            return .pink
        }
    }
    
    var iconName: String {
        switch self {
        case .books:
            return "books.vertical.fill"
        case .music:
            return "music.note"
        case .movies:
            return "popcorn"
        case .clothes:
            return "tshirt.fill"
        case .restaurants:
            return "fork.knife"
        case .memes:
            return "face.smiling"
        case .electronics:
            return "iphone.sizes"
        }
    }
}
