////
////  DashboardViewModel.swift
////  SaveInfo
////
////  Created by Valery Zazulin on 17/06/25.
////
//import SwiftUI
//
//@Observable
//class DashboardViewModel {
//    
//    var infoObjects: [InfoObject] = []
//    
//    var showAddNewObjectModal: Bool = false
//    var availableTypes: [InfoType] = [.all]
//    
//    var searchText: String = ""
//    
//    var showFavorite: Bool = false
//    var selectedCategories: [Category] = []
//    var selectedType: InfoType = .all
//    
//    var filteredObjects: [InfoObject] {
//        
//        let selectedCtegoriesNames = selectedCategories.map(\.name)
//        
//        return infoObjects.filter { infoObject in
//            let matchesCategory = selectedCtegoriesNames.isEmpty || selectedCtegoriesNames.contains(infoObject.category.name)
//            
//            let matchesSearchText: Bool
//            
//            if searchText.isEmpty {
//                matchesSearchText = true
//            } else {
//                let lowercasedSearch = searchText.lowercased()
//                matchesSearchText =
//                (infoObject.title?.lowercased().contains(lowercasedSearch) ?? false) ||
//                (infoObject.stringURL?.lowercased().contains(lowercasedSearch) ?? false) ||
//                (infoObject.comment?.lowercased().contains(lowercasedSearch) ?? false) ||
//                infoObject.tags.contains(where: { $0.lowercased().contains(lowercasedSearch) }) ||
//                infoObject.dateAdded.description.lowercased().contains(lowercasedSearch)
//            }
//            
//            let matchesFavorite = !showFavorite || infoObject.isFavorite
//            
//            switch selectedType {
//            case .all:
//                return matchesCategory && matchesFavorite && matchesSearchText
//            case .images:
//                return matchesCategory && infoObject.hasImageFromLibrary && matchesFavorite && matchesSearchText
//            case .links:
//                return matchesCategory && infoObject.stringURL != nil && !infoObject.stringURL!.isEmpty && matchesFavorite && matchesSearchText
//            }
//        }
//    }
//}
