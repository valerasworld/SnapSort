//  Favorites.swift
//  SaveInfo
//
//  Created by Cristina Valenziano on 29/05/25.
//

import SwiftUI

@Observable
class Favorites {
    private var items: Set<String>
    private let key = "Favorites"

    init() {
        items = []
    }
    func contains( infoObject: InfoObject) -> Bool {
        items.contains(infoObject.id)
    }

    func add( infoObject: InfoObject) {
        items.insert(infoObject.id)
    }

    func remove(_ infoObject: InfoObject) {
        items.remove(infoObject.id)
        save()
    }

    func save() {

    }
}
