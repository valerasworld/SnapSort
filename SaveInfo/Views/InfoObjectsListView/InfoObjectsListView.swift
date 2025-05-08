//
//  InfoObjectsListView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct InfoObjectsListView: View {
    
    var category: Category?
    var infoObjects: [InfoObject]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(infoObjects, id: \.self) { object in
                    InfoObjectCardView(infoObject: object, previewMode: .category)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

        }
        .navigationTitle(category?.rawValue.capitalized ?? "Timeline")
    }
        
}
