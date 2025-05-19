//
//  CategoryCardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct CategoryCardView: View {
    
    var category: Category
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color("white"))
                .frame(height: 90)
                
            HStack {
                HStack(alignment: .center, spacing: 2) {
                    Text(category.rawValue.capitalized)
                        .font(.headline)
                        .foregroundStyle(
                            category.color.gradient
                        )
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(category.color.gradient)
                        .bold()
                }
                Spacer()
                Image(systemName: category.iconName)
                    .foregroundStyle(category.color.gradient)
                    .font(.largeTitle)

            }
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(category.color.gradient, lineWidth: 3)
                    .frame(height: 90)
            }
        }
    }
}
