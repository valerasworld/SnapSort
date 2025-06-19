//
//  ToolbarButtons.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 18/06/25.
//

import SwiftUI

struct SettingsMenuToolbarButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    var userData: UserDataManager
    
    var body: some View {
        Menu {
            Menu("Color Theme") {
                Picker("Color Theme", selection: Binding(
                    get: { userData.colorTheme },
                    set: { userData.colorTheme = $0 }
                )) {
                    ForEach(ColorTheme.allCases, id: \.self) { theme in
                        Text(theme.rawValue.capitalized).tag(theme)
                    }
                }
            }
            .pickerStyle(.inline)
        } label: {
            Image(systemName: "gearshape")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.title3)
        }
    }
}

struct FavoritesFilterToolbarButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showFavorite: Bool
    
    var body: some View {
        Button {
            withAnimation(.snappy) {
                showFavorite.toggle()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        } label: {
            Image(systemName: showFavorite ? "heart.fill" : "heart")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.title3)
        }
    }
}

struct AddNewToolbarButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showModal: Bool
    
    var body: some View {
        Button {
            showModal = true
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.title3)
        }
    }
}

