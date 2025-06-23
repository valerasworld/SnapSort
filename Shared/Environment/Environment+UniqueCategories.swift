//
//  Environment+UniqueCategories.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 20/06/25.
//

import SwiftUI

private struct UniqueCategoriesKey: EnvironmentKey {
    static let defaultValue: [Category] = []
}

extension EnvironmentValues {
    var uniqueCategories: [Category] {
        get { self[UniqueCategoriesKey.self] }
        set { self[UniqueCategoriesKey.self] = newValue }
    }
}
