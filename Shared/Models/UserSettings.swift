//
//  UserData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI
import SwiftData

@Model
class UserSettings {
    
    var colorThemeRaw: String
    
    var colorTheme: ColorTheme {
        get { ColorTheme(rawValue: colorThemeRaw) ?? .pastel }
        set { colorThemeRaw = newValue.rawValue }
    }
    
    init(colorTheme: ColorTheme = .pastel) {
        self.colorThemeRaw = colorTheme.rawValue
    }

}

@Observable
final class UserDataManager {
    private var context: ModelContext
    private var userSettings: UserSettings
    
    private init(context: ModelContext, userSettings: UserSettings) {
            self.context = context
            self.userSettings = userSettings
        }

        static func load(from context: ModelContext) -> UserDataManager {
            if let existing = try? context.fetch(FetchDescriptor<UserSettings>()).first {
                return UserDataManager(context: context, userSettings: existing)
            } else {
                let newSettings = UserSettings()
                context.insert(newSettings)
                return UserDataManager(context: context, userSettings: newSettings)
            }
        }

        var colorTheme: ColorTheme {
            get { userSettings.colorTheme }
            set { userSettings.colorTheme = newValue }
        }

    
}


