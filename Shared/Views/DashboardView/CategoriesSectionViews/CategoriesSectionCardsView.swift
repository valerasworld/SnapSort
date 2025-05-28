//
//  CategoriesSectionView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct CategoriesSectionCardsView: View {
    
    var userData: UserDataManager
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(userData.findUniqueCategories(), id: \.rawValue) { category in
                NavigationLink {
//                    InfoObjectsListView(category: category, infoObjects: userData.filterByCategory(category: category))
                } label: {
                    CategoryCardView(category: category)
                }
                
                
            }
        }
        .padding(.horizontal)
    }
}
