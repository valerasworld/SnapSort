//
//  SharedModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 20/06/25.
//

import Foundation
import SwiftData

enum SharedModel {
    static let storeURL: URL = {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.vzazulin.SnapSort")!
        return container.appendingPathComponent("SaveInfo.sqlite")
    }()

    static let configuration = ModelConfiguration(
        "Model",
        url: storeURL
    )

    static let container = try! ModelContainer(
        for: InfoObject.self, UserSettings.self,
        configurations: configuration
    )
}
