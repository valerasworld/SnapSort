//
//  SaveInfoApp.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI

@main
struct SaveInfoApp: App {
    @StateObject private var infoObject = InfoObject(category: Category.allCases.randomElement()!, dateAdded: Date())
    var body: some Scene {
        WindowGroup {
            DashboardView(infoObject: infoObject)
        }
    }
}
