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
    @State var showModal: Bool = false
    let infoObject: InfoObject
    
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
                    Button(action: {
                        showModal = true
                    })
                        {
                            Image(systemName: "plus")
                                .foregroundStyle(Color("black"))
                        }
                    
                }
            }
            .sheet(isPresented: $showModal) {
                AddItemView(infoObject: infoObject, category: Category.allCases, titleNewItem: "", descriptionNewItem: "", showModal: $showModal)
            }
            
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView(infoObject: .init(category: Category.books, dateAdded: Date()))
}


