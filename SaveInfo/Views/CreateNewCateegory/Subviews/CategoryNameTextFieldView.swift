//
//  CategoryNameTextFieldView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//

import SwiftUI

struct CategoryNameTextFieldView: View {
    
    @Environment(\.colorScheme) var colorScheme
                
    @FocusState var categoryNameInFocus: Bool
    
    @Binding var newCategoryName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.title3)
            
            TextField("Add Name...", text: $newCategoryName)
                .clearButton(text: $newCategoryName)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? Color(#colorLiteral(red: 0.9019606709, green: 0.9019609094, blue: 0.9062663913, alpha: 1)) : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
                .submitLabel(.done)
        }
    }
}
