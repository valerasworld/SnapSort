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
            .overlay {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .padding()
                    .font(.title2)
                    .bold()
                    .background {
                        Color.black
                    }
                    .clipShape(Circle())
                    .shadow(radius: 3)
                    .offset(x: 155, y: 220)
            }
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView()
}


