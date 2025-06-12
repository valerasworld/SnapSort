//
//  PreviewSampleData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//

import Foundation
import SwiftData

@MainActor
func previewContainer() -> (container: ModelContainer, userDataManager: UserDataManager) {
    do {
        let container = try ModelContainer(
            for: InfoObject.self, UserSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext

        // Add InfoObjects if empty
        if try context.fetch(FetchDescriptor<InfoObject>()).isEmpty {
            SampleObjects.contents.forEach { context.insert($0) }
        }

        // Load or create UserSettings
        let userDataManager = UserDataManager.load(from: context)

        return (container, userDataManager)

    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}

@MainActor
func previewBigContainer() -> (container: ModelContainer, userDataManager: UserDataManager) {
    do {
        let container = try ModelContainer(
            for: InfoObject.self, UserSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext

        // Add InfoObjects if empty
        if try context.fetch(FetchDescriptor<InfoObject>()).isEmpty {
            SampleObjects.longContents.forEach { context.insert($0) }
        }

        // Load or create UserSettings
        let userDataManager = UserDataManager.load(from: context)

        return (container, userDataManager)

    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}

@MainActor
func previewShortContainer() -> (container: ModelContainer, userDataManager: UserDataManager) {
    do {
        let container = try ModelContainer(
            for: InfoObject.self, UserSettings.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext

        // Add InfoObjects if empty
        if try context.fetch(FetchDescriptor<InfoObject>()).isEmpty {
            SampleObjects.shortContents.forEach { context.insert($0) }
        }

        // Load or create UserSettings
        let userDataManager = UserDataManager.load(from: context)

        return (container, userDataManager)

    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}

