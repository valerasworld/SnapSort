//
//  TagsView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct TagsView: View {
    
    var category: Category
    
    var body: some View {
        ScrollView([.horizontal]) {
            HStack {
                Spacer()
                    .frame(width: 15)
                ForEach(Category.allCases, id: \.self) { category in
                    HStack {
                        Image(systemName: category.iconName)
                            .foregroundStyle(category.color)
                        Text(category.rawValue.capitalized)

                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.12), radius: 10)
                    }
                }
                
                Spacer()
                    .frame(width: 15)
            }
            .padding(.vertical, 10)
            
        }
        .scrollIndicators(.hidden)
    }
}
