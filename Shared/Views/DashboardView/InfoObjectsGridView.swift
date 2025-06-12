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
    
    var filteredObjects: [InfoObject]
    
    private var groupedObjects: [InfoObjectGroup] {
           groupByDate(filteredObjects)
       }
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ScrollView {
//            ForEach(infoObjects.groupByDate(), id: \.date) { group in
//            ForEach(filteredObjects.groupByDate(), id: \.id) { group in
//            ForEach(groupedObjects, id: \.id) { group in
//                Section(header: DateSectionHeaderView(group: group)) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(/*group.infoObjects*/filteredObjects, id: \.id) { object in
                            InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: object))
                               
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
                    .animation(.snappy, value: filteredObjects)
//                }
//            }
        }
        .scrollClipDisabled()
        .overlay {
            if filteredObjects.isEmpty {
                ContentUnavailableView {
                    Label("You haven't added any objects yet", systemImage: "plus")
                }
            }
        }
    }
    
    func groupByDate(_ array: [InfoObject]) -> [InfoObjectGroup] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let groupedDict = Dictionary(grouping: array) { formatter.string(from: $0.dateAdded) }

        return groupedDict.map { dateString, objects in
            InfoObjectGroup(formattedDate: dateString, infoObjects: objects)
        }
        .sorted { $0.formattedDate > $1.formattedDate }
    }
    
}

struct DateSectionHeaderView: View {
//    var group: (date: Date, infoObjects: [InfoObject])
//    
//    var body: some View {
//        Text(formattedDate(group.date))
//            .font(.title3)
//            .bold()
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.leading)
//    }
    var group: InfoObjectGroup

        var body: some View {
            Text(group.formattedDate)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
    
//    // Helper for formatting dates
//    func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: date)
//    }
}

#Preview {
//    InfoObjectsGridView(selectedCategories: [], selectedType: .all)
    InfoObjectsGridView(filteredObjects: [])
//        .modelContainer(previewContainer)
}
