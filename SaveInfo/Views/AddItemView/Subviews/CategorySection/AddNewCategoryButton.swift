//
//  AddNewCategoryButton.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct AddNewCategoryButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    @Environment(\.uniqueCategories) var uniqueCategories
    
    @Binding var isCreateCategorySheetPresented: Bool
    @Binding var selectedCategory: Category?
    
    var body: some View {
        Button {
            isCreateCategorySheetPresented.toggle()
        } label: {
            HStack {
                Image(systemName: "plus.circle")
                Text("Add New")
                
            }
            .foregroundStyle(colorScheme == .light ? .black : .white)
        }
        .padding(.horizontal, 12)
        .padding(.top, !uniqueCategories.isEmpty || selectedCategory != nil ? 6 : 12)
        .padding(.bottom, 12)
        .sheet(isPresented: $isCreateCategorySheetPresented) {
            CreateCategorySheetView(selectedCategory: $selectedCategory)
        }
    }
}

#Preview {
    AddNewCategoryButton(isCreateCategorySheetPresented: .constant(false), selectedCategory: .constant(nil))
}
