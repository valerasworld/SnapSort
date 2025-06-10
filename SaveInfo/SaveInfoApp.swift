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
    
    let container = try! ModelContainer(for: InfoObject.self, UserSettings.self)
    
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(container)
            let userDataManager = UserDataManager.load(from: context)
            
            DashboardView(selectedCategories: [])
                .environment(userDataManager)
                .modelContainer(container)
        }
    }
}
