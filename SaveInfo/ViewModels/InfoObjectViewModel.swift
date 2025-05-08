//
//  InfoObjectViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//

import SwiftUI

@Observable
class InfoObjectViewModel {
    var infoObject: InfoObject
    
    init(infoObject: InfoObject) {
        self.infoObject = infoObject
    }
    
    func loadPreview() {
        if !hasURL() {
            return
        }
        // Extracting URL Metadata...
        // Before that adding loading indicator...
        guard let stringURL = infoObject.stringURL else {
            return
        }
        if let url = URL(string: stringURL) {
            infoObject.previewLoading = true
            infoObject.linkURL = url
        }
    }
    
    // Checking if InfoObject has URL...
    func hasURL() -> Bool {
        guard let stringURL = infoObject.stringURL else {
            return false
        }
        if let url = URL(string: stringURL) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}
