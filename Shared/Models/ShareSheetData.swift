//
//  ShareSheetData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 21/06/25.
//

import Foundation

struct ShareSheetData: Equatable {
    var title: String? = nil
    var imageData: Data? = nil
    var urlString: String? = nil
    var hasChosenImage: Bool = false
    
    static func == (lhs: ShareSheetData, rhs: ShareSheetData) -> Bool {
        lhs.title == rhs.title &&
        lhs.imageData == rhs.imageData &&
        lhs.urlString == rhs.urlString &&
        lhs.hasChosenImage == rhs.hasChosenImage
    }
}
