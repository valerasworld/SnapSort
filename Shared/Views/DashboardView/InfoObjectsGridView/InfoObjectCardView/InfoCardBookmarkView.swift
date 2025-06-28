//
//  InfoCardBookmarkView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 20/06/25.
//
import SwiftUI

struct InfoCardBookmarkView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var category: Category
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.clear)
                .background(Rectangle().fill(category.color(for: userData.colorTheme, colorScheme: colorScheme)))
            
            VStack {
                Spacer()
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(colorScheme == .light ? .white : .black)
                    .bold()
                Spacer()
                
            }
            
        }
        .frame(width: 30, height: 44)
        .roundedCorners(10, corners: [.bottomLeft, .bottomRight])
        .padding(.bottom, 8)
    }
}
