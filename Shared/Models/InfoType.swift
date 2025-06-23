//
//  InfoType.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI

enum InfoType {
    case all
    case links
    case images
    
    var typeName: LocalizedStringKey {
        switch self {
        case .all: return "All"
        case .links: return "Links"
        case .images: return "Images"
        }
    }
}
