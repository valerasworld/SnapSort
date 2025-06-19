//
//  DashboardViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 17/06/25.
//
import SwiftUI

@Observable
class DashboardViewModel {
    
    var showAddNewObjectModal: Bool = false
    
    var infoObjects: [InfoObject] = []
    
    var searchText: String = ""
    var showFavorite: Bool = false
    var availableTypes: [InfoType] = [.all]
    var selectedType: InfoType = .all
    var selectedCategories: [Category] = []
    
    var filteredObjects: [InfoObject] {
        let filters: [InfoObjectFilter] = [
            SearchTextFilter(searchText: searchText),
            CategoryFilter(selectedCategories: selectedCategories),
            FavoriteFilter(showFavorite: showFavorite),
            TypeFilter(infoType: selectedType)
        ]
        let composite = CompositeFilter(filters: filters)
        return infoObjects.filter { composite.matches($0) }
    }
    
    func findUniqueCategories() -> [Category] {
        let categories = infoObjects.map(\.category)
        let uniqueCategories = Set(categories)
        return Array<Category>(uniqueCategories).sorted { $0.name < $1.name }
    }

    private func findAvailableTypes(for infoObjects: [InfoObject]) -> [InfoType] {
        guard !infoObjects.isEmpty else { return [.all] }

        let hasLinks = infoObjects.map { $0.hasValidLink }
        let hasImages = infoObjects.map { $0.hasImageFromLibrary }

        let hasNotOnlyLinks = hasLinks.contains(true) && hasLinks.contains(false)
        let hasNotOnlyImages = hasImages.contains(true) && hasImages.contains(false)

        var types: [InfoType] = [.all]
        if hasNotOnlyLinks {
            types.append(.links)
        }
        if hasNotOnlyImages {
            types.append(.images)
        }
        return types
    }
    
    func updateInfoTypes() {
        availableTypes = findAvailableTypes(for: infoObjects)
    }

    func updateInfoTypes(with infoObject: InfoObject) {
        availableTypes = findAvailableTypes(for: [infoObject])
    }
    
    func refreshViewModelData(_ infoObjects: [InfoObject]) {
        self.infoObjects = infoObjects
        updateInfoTypes()
    }
    
    func groupByDate(_ array: [InfoObject]) -> [InfoObjectGroup] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let groupedDict = Dictionary(grouping: array) { formatter.string(from: $0.dateAdded) }
        
        return groupedDict.map { dateString, objects in
            InfoObjectGroup(formattedDate: dateString, infoObjects: objects)
        }
        .sorted { $0.formattedDate > $1.formattedDate }
    }
    
}

struct SegmentedControlStyleProvider {
    let userData: UserDataManager
    let colorScheme: ColorScheme
    let uniqueCategories: [Category]
    let selectedCategories: [Category]
    let infoObjects: [InfoObject]
    let availableTypes: [InfoType]
    let selectedType: InfoType
    
    func textColor(for type: InfoType) -> Color {
        availableTypes != [.all] ?
        (selectedType == type ? .white : Color(#colorLiteral(red: 0.5254898071, green: 0.525490582, blue: 0.5426864624, alpha: 1))) :
        (colorScheme == .light ? Color(#colorLiteral(red: 0.4941170812, green: 0.4941180944, blue: 0.5156010985, alpha: 1)) : Color(#colorLiteral(red: 0.6117640734, green: 0.6117651463, blue: 0.6375455856, alpha: 1)))
    }
    
    func shadeColor() -> Color {
        colorScheme == .light ?
        (availableTypes == [.all] ? Color(#colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8901960784, alpha: 1)) : Color(#colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8901960784, alpha: 1)).opacity(0.3))
        : (availableTypes == [.all] ? Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)) : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)).opacity(0.3))
    }
    
    func gradientColors() -> [Color] {
        let categories: [Category]
        
        if selectedCategories.isEmpty {
            categories = uniqueCategories.sortByColor()
        } else {
            categories = selectedCategories.sortByColor()
        }
        
        return categories.map {
            $0.color(for: userData.colorTheme, colorScheme: colorScheme)
        }
        
    }
    
    func backgroundColor() -> Color {
        colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1))
    }
}
