//
//  SaveInfoApp.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI
import SwiftData

@main
struct SaveInfoApp: App {
    
//    init() { UINavigationBar.removeDividerLine() }
    
    let container = try! ModelContainer(for: InfoObject.self, UserSettings.self)
    
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(container)
            let userDataManager = UserDataManager.load(from: context)
            
            DashboardView(selectedCategories: [], selectedType: .all, availableTypes: [])
                .environment(userDataManager)
                .modelContainer(container)
        }
    }
}
