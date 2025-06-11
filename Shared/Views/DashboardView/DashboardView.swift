//
//  DashboardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
        
    @State var searchText: String = ""
    @State var showModal: Bool = false
    
    @State var showFavorite: Bool = false
    @State var selectedCategories: [Category] = []
    @State var selectedType: InfoType = InfoType.all

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \InfoObject.dateAdded) private var infoObjects: [InfoObject]
    
    var filteredObjects: [InfoObject] {
        
        let selectedCtegoriesNames = selectedCategories.map(\.name)
        
        return infoObjects.reversed().filter { infoObject in
            let matchesCategory = selectedCtegoriesNames.isEmpty || selectedCtegoriesNames.contains(infoObject.category.name)
            
            let matchesSearchText: Bool
            
            if searchText.isEmpty {
                matchesSearchText = true
            } else {
                let lowercasedSearch = searchText.lowercased()
                matchesSearchText =
                (infoObject.title?.lowercased().contains(lowercasedSearch) ?? false) ||
                (infoObject.stringURL?.lowercased().contains(lowercasedSearch) ?? false) ||
                (infoObject.comment?.lowercased().contains(lowercasedSearch) ?? false) ||
                infoObject.tags.contains(where: { $0.lowercased().contains(lowercasedSearch) })
            }
            
            let matchesFavorite = !showFavorite || infoObject.isFavorite
            
            switch selectedType {
                case .all:
                    return matchesCategory && matchesFavorite && matchesSearchText
                case .images:
                return matchesCategory && infoObject.hasImageFromLibrary && matchesFavorite && matchesSearchText
                case .links:
                    return matchesCategory && infoObject.stringURL != nil && !infoObject.stringURL!.isEmpty && matchesFavorite && matchesSearchText
                }
        }
    }
    
    
    var body: some View {
        NavigationStack/*(path: $navigationPath)*/ {
            
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
                InfoObjectsGridView(filteredObjects: filteredObjects)
                    .animation(.snappy, value: searchText)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SnapSort")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .onChange(of: searchText) { _, newValue in
                withAnimation(.snappy) {
                    self.searchText = newValue
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Menu("Color Theme") {
                            Picker("Color Theme", selection: Binding(
                                get: { userData.colorTheme },
                                set: { userData.colorTheme = $0 }
                            )) {
                                ForEach(ColorTheme.allCases, id: \.self) { theme in
                                    Text(theme.rawValue.capitalized).tag(theme)
                                }
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title3)
                    }
                    
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.snappy) {
                            showFavorite.toggle()
                        }
                        
                    } label: {
                        Image(systemName: showFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showModal = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                            .font(.title3)
                    }
                }
            })
            .sheet(isPresented: $showModal) {
                AddItemView(infoObject: nil, isEditing: false, infoObjects: infoObjects)
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
//        .environment(userData)
    }
}

#Preview {
    let (container, userDataManager) = /*previewBigContainer()*/previewContainer()
    DashboardView(selectedCategories: [])
//        .modelContainer(previewContainer)
        .modelContainer(container)
        .environment(userDataManager)
//        .environment(userData)
                             
}








