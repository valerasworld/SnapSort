//
//  TitleFormAddOrEditItemView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct TitleFormAddOrEditItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var title: String
    var infoObject: InfoObject?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TITLE")
                .font(.footnote)
                .foregroundStyle(colorScheme == .light ? .black.opacity(0.5) : .white.opacity(0.5))
                .padding(.top, 8)
                .padding(.horizontal, 12)
            TextField("Add Title", text: $title)
                .font(.title3)
                .padding(8)
                .padding(.horizontal, 4)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                }
        }
        .padding(.horizontal, 16)
        .onChange(of: title) { _, newValue in
            if newValue != infoObject?.title {
                infoObject?.hasUsersTitle = true
            }
        }
    }
}
