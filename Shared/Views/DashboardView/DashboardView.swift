//
//  DashboardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @State var userData = UserDataManager()
    @State var searchText: String = ""
    @State var showModal: Bool = false
    
    @State var selectedCategories: [Category] = []
    @State var selectedType: InfoType = InfoType.all
    @State private var favorites = Favorites() // ?
    
    // SwiftData -------------
    @State private var navigationPath: [InfoObject] = []
    @Environment(\.modelContext) private var modelContext
    @Query private var infoObjects: [InfoObject]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ResizableHeaderScrollView {
                
            } stickyHeader: {
                ObjectTypeSegmentedControlView(infoObjects: infoObjects, selectedCategories: $selectedCategories, selectedType: $selectedType)
            } categoryFilter: {
                CategoriesFilterView(infoObjects: infoObjects, selectedCategories: $selectedCategories)
                    .frame(maxWidth: .infinity)
            } background: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
            } content: {
                InfoObjectsGridView(selectedCategories: selectedCategories, selectedType: selectedType)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SnapSort")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar(content: {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .bold()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                 
                        
                        showModal = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("black"))
                    }
                }
            })
            .sheet(isPresented: $showModal) {
                AddItemView(
                    infoObject: InfoObject(
                        title: "",
                        stringURL: "",
                        tags: [],
                        category: Category(name: "No Category", colorName: "gray", iconName: "questionmark"),
                        dateAdded: Date.now,
                        comment: ""
                    ),
                )
            }
//            
//            .onAppear {
//                let demoObjects = SampleObjects.contents
//                for demoObject in demoObjects {
//                    modelContext.insert(demoObject)
//                }
//                
//            }
            
        }
        .environment(userData)
        .environment(favorites)
    }
}

#Preview {
    DashboardView(selectedCategories: [])
        .modelContainer(previewContainer)
}








