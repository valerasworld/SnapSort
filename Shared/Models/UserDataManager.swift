//
//  UserData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

@Observable
class UserDataManager {
    var useMockData: Bool = true
    
    var mockData: [InfoObject] = SampleObjects.contents
    var liveObjects: [InfoObject] = []
    var objects: [InfoObject] {
        return useMockData ? mockData : liveObjects
    }
    
    var uniqueCategories: [Category] {
        var categories: [Category] = []
        categories = Array(Set(objects.map { $0.category }))
        return categories.sorted { $0.name < $1.name }
    }
    
    let initialCategory: Category = Category(name: "No Category", colorName: "gray", iconName: "questionmark")
    
    var groupedObjects: [(date: Date, infoObjects: [InfoObject])] {
        let groupedDictionary = Dictionary(grouping: objects) { infoObject in
            (infoObject.dateAdded).startOfDay()
        }
        return groupedDictionary
            .map { ($0.key, $0.value) }
            .sorted { $0.0 > $1.0 }
    }
}

extension Date {
    func formattedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
