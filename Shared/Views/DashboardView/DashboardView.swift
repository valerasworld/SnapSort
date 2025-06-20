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
    
    @State var viewModel = DashboardViewModel()

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \InfoObject.dateAdded) var infoObjects: [InfoObject]
    
    var body: some View {
        NavigationStack {
            
            ResizableHeaderScrollView {
                
            } stickyHeader: {
                if viewModel.availableTypes != [.all] {
                    ObjectTypeSegmentedControlView(viewModel: viewModel)
                }
            } categoryFilter: {
                if viewModel.findUniqueCategories().count > 1 {
                    CategoriesFilterView(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                } else {
                    Color.clear
                        .frame(height: 6)
                }
                
            } background: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
            } content: {
                if !infoObjects.isEmpty {
                    InfoObjectsGridView(dashboardViewModel: viewModel)
                        .animation(.snappy, value: viewModel.searchText)
                }
            }
            .overlay {
                if infoObjects.isEmpty {
                    ContentUnavailableView("Nothing Saved Yet", systemImage: "plus", description: Text("Press 'Plus Button' to Add Your First Item"))
                        .onTapGesture {
                            viewModel.showAddNewObjectModal.toggle()
                        }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SnapSort")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .onChange(of: viewModel.searchText) { _, newValue in
                withAnimation(.snappy) {
                    viewModel.searchText = newValue
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    SettingsMenuToolbarButton(userData: userData)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    FavoritesFilterToolbarButton(showFavorite: $viewModel.showFavorite)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AddNewToolbarButton(showModal: $viewModel.showAddNewObjectModal)
                }
            }
            .sheet(isPresented: $viewModel.showAddNewObjectModal) {
                AddOrEditItemView(infoObject: nil, userCategories: viewModel.findUniqueCategories())
            }
        }
        .onAppear {
            viewModel.refreshViewModelData(infoObjects)
            viewModel.selectedType = .all
        }
        .onChange(of: infoObjects) { _, newValue in
            withAnimation(.snappy) {
                viewModel.refreshViewModelData(newValue)
            }
        }
    }
}

#Preview {
    let (container, userDataManager) = previewContainer(size: .empty)
    DashboardView()
        .environment(userDataManager)
        .modelContainer(container)
                             
}

#Preview("Italian") {
    let (container, userDataManager) = previewContainer(size: .empty)
    DashboardView()
        .environment(\.locale, Locale(identifier: "it"))
        .environment(userDataManager)
        .modelContainer(container)
                             
}

#Preview("Русский") {
    let (container, userDataManager) = previewContainer(size: .empty)
    DashboardView()
        .environment(\.locale, Locale(identifier: "ru"))
        .environment(userDataManager)
        .modelContainer(container)
                             
}
