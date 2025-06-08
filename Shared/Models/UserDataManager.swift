//
//  UserData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

@Observable
class UserDataManager {
    
}

extension Date {
    func formattedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
