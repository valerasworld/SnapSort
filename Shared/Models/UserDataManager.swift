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
    
    let initialCategory: Category = Category(name: "No Category", colorName: "gray", iconName: "questionmark")
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
