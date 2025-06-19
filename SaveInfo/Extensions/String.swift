//
//  String.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 11/06/25.
//
import SwiftUI

extension String {
    var sanitizedURLString: String {
        var urlString = self.trimmingCharacters(in: .whitespacesAndNewlines)

        if !urlString.lowercased().hasPrefix("http://") &&
            !urlString.lowercased().hasPrefix("https://") {
            urlString = "https://" + urlString
        }
        
        if urlString.lowercased() == "https://" {
            return ""
        } else {
            return urlString.lowercased()
        }
    }
}

extension String {
    func isValidURL() -> Bool {
        guard let url = URL(string: self),
              url.scheme?.hasPrefix("http") == true,
              url.host != nil else {
            return false
        }
        return true
    }
}
