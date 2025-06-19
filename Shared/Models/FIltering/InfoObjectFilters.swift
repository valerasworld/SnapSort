//
//  InfoObjectFilters.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 17/06/25.
//

import SwiftUI

struct CompositeFilter: InfoObjectFilter {
    let filters: [InfoObjectFilter]

    func matches(_ infoObject: InfoObject) -> Bool {
        filters.allSatisfy { $0.matches(infoObject) }
    }
}


protocol InfoObjectFilter {
    func matches(_ infoObject: InfoObject) -> Bool
}

struct SearchTextFilter: InfoObjectFilter {
    let searchText: String

    func matches(_ infoObject: InfoObject) -> Bool {
        guard !searchText.isEmpty else { return true }
        let lowercasedSearch = searchText.lowercased()
        
        return
            (infoObject.title?.lowercased().contains(lowercasedSearch) ?? false) ||
            (infoObject.stringURL?.lowercased().contains(lowercasedSearch) ?? false) ||
            (infoObject.comment?.lowercased().contains(lowercasedSearch) ?? false) ||
            infoObject.tags.contains(where: { $0.lowercased().contains(lowercasedSearch) }) ||
            infoObject.dateAdded.description.lowercased().contains(lowercasedSearch)
    }
}

struct CategoryFilter: InfoObjectFilter {
    let selectedCategories: [Category]

    func matches(_ infoObject: InfoObject) -> Bool {
        selectedCategories.isEmpty || selectedCategories.map(\.name).contains(infoObject.category.name)
    }
}

struct TypeFilter: InfoObjectFilter {
    let infoType: InfoType

    func matches(_ infoObject: InfoObject) -> Bool {
        switch infoType {
        case .all: return true
        case .images: return infoObject.hasImageFromLibrary
        case .links: return infoObject.hasValidLink
        }
    }
}

struct FavoriteFilter: InfoObjectFilter {
    let showFavorite: Bool

    func matches(_ infoObject: InfoObject) -> Bool {
        !showFavorite || infoObject.isFavorite
    }
}
