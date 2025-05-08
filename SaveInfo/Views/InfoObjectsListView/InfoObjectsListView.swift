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
    
    var body: some View {
        ScrollView {
            VStack {
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
