//
//  CategoriesManager.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 20/06/25.
//

import SwiftUI

struct CategoryManager {
    static func findUniqueCategories(from infoObjects: [InfoObject]) -> [Category] {
        let categories = infoObjects.map(\.category)
        let uniqueCategories = Set(categories)
        return Array<Category>(uniqueCategories).sorted { $0.name < $1.name }
    }
}

