//
//  Date.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 17/06/25.
//
import SwiftUI

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
