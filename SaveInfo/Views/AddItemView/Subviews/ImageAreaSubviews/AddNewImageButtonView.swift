//
//  AddNewImageButtonView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct AddNewImageButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var selectedCategory: Category?
    @Binding var isPhotoPickerPresented: Bool
    
    
    var body: some View {
        Button {
            isPhotoPickerPresented.toggle()
        } label : {
            Label {
                Text("Add New Image")
                    .font(.title3)
            } icon: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .bold()
            .foregroundStyle(
                (selectedCategory?.color(for: userData.colorTheme, colorScheme: colorScheme) ?? Category.noCategory.color(for: userData.colorTheme, colorScheme: colorScheme)))
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    AddNewImageButtonView(isPhotoPickerPresented: .constant(false))
}
