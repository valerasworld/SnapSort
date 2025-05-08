//
//  CategoriesSectionView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct CategoriesSectionCardsView: View {
    
    var userData: UserData
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(userData.findUniqueCategories(), id: \.rawValue) { category in
                NavigationLink {
                    InfoObjectsListView(category: category, infoObjects: userData.filterByCategory(category: category))
                } label: {
                    CategoryCardView(category: category)
                }
                
                
            }
        }
        .padding(.horizontal)
    }
}
