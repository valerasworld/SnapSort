//
//  InfoObjectListViewMainScreenView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/05/25.
//

import SwiftUI
import SwiftData

struct InfoObjectsGridView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var dashboardViewModel: DashboardViewModel
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(dashboardViewModel.filteredObjects, id: \.id) { object in
                    InfoObjectCardView(cardViewModel: InfoObjectCardViewModel(infoObject: object), dashboardViewModel: dashboardViewModel)
                    
                        .contextMenu {
                            Button {
                                withAnimation(.snappy) {
                                    object.isFavorite.toggle()
                                }
                            } label: {
                                Label(object.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: "heart")
                            }
                            Button(role: .destructive) {
                                withAnimation(.snappy) {
                                    modelContext.delete(object)
                                    dashboardViewModel.updateInfoTypes()
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .transition(.opacity)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 6)
            .animation(.snappy, value: dashboardViewModel.filteredObjects)
        }
        .scrollClipDisabled()
    }
    
}

struct DateSectionHeaderView: View {
    var group: InfoObjectGroup
    
    var body: some View {
        Text(group.formattedDate)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
}

#Preview {
    let (container, userDataManager) = previewContainer(size: .small)
    InfoObjectsGridView(dashboardViewModel: DashboardViewModel())
        .modelContainer(container)
        .environment(userDataManager)
}
