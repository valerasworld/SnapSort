//
//  AddImageView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct AddImageView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    @Binding var isPhotoPickerPresented: Bool
    var selectedCategory: Category?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? .gray, (colorScheme == .light ? .white : .black)], startPoint: .top, endPoint: .bottom)
            Color.clear
                .background(.ultraThinMaterial)
            ContentUnavailableView(
                "Add Image",
                systemImage: "plus",
                description: Text("No Image here yet"))
            .onTapGesture {
                isPhotoPickerPresented.toggle()
            }
        }
    }
}

#Preview {
    AddImageView(isPhotoPickerPresented: .constant(false))
}
