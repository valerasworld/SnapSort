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
                LazyVStack(alignment: .leading) {
                    Group {
                        RecentlyAddedSectionHeaderView(userData: userData)
                        RecentlyAddedSectionScrollView(userData: userData)
                    }
                    
                    
                    // SEGMENTED CONTROL ?????????!!!!!!!!!!!!
                    // ADDING NEW ELEMENT BUTTON !!!!!
                    Group {
                        CategoriesSectionHeaderView()
                        CategoriesSectionCardsView(userData: userData)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("black"))
                    }
                }
                
            }
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView()
}


