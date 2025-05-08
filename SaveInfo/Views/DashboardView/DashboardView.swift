//
//  DashboardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI

struct DashboardView: View {
    
    @State var userData = UserData()
    @State var searchText: String = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                
                RecentlyAddedSectionHeaderView(userData: userData)
                RecentlyAddedSectionScrollView(userData: userData)
                
                // SEGMENTED CONTROL ?????????!!!!!!!!!!!!
                // ADDING NEW ELEMENT BUTTON !!!!!
                CategoriesSectionHeaderView()
                CategoriesSectionCardsView(userData: userData)
            }
            .navigationTitle("Dashboard")
            .searchable(text: $searchText)
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView()
}


