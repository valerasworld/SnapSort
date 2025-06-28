//
//  LinkFormAddOrEditItemView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct LinkFormAddOrEditItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var stringURL: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("LINK")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            TextField("Add Link", text: $stringURL)
                .clearButton(text: $stringURL)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
        }
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    LinkFormAddOrEditItemView(stringURL: .constant(""))
}
