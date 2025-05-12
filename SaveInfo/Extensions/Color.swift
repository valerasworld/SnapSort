//
//  Color.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 12/05/25.
//

import SwiftUI
import UIKit

extension Color {
    func isLight(threshold: CGFloat = 0.6) -> Bool {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate luminance
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        return luminance > threshold
    }
}
