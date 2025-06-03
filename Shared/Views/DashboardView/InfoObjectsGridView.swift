//
//  InfoObjectListViewMainScreenView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/05/25.
//

import SwiftUI
import SwiftData

struct InfoObjectsGridView: View {
    
//    var userData: UserDataManager
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
//    var infoObjects: [InfoObject]
    // SwiftData -------------
    @Environment(\.modelContext) private var modelContext
    @Query private var infoObjects: [InfoObject]

        init(selectedCategories: [Category], selectedType: InfoType = .all) {
            let categoryNames = selectedCategories.map(\.name)

            let predicate: Predicate<InfoObject>

            switch selectedType {
            case .all:
                predicate = #Predicate {
                    categoryNames.isEmpty || categoryNames.contains($0.category.name)
                }
            case .images:
                predicate = #Predicate {
                    (categoryNames.isEmpty || categoryNames.contains($0.category.name)) &&
                    $0.imageData != nil
                }
            case .links:
                predicate = #Predicate {
                        (categoryNames.isEmpty || categoryNames.contains($0.category.name)) &&
                        $0.stringURL != nil && !$0.stringURL!.isEmpty
                    }
            }

            _infoObjects = Query(filter: predicate, sort: [SortDescriptor(\.dateAdded, order: .reverse)])
        }
    
    var body: some View {
        ScrollView {
//            ForEach(infoObjects.groupByDate(), id: \.date) { group in
//                Section(header: DateSectionHeaderView(group: group)) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(/*group.*/infoObjects, id: \.self) { object in
                            InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: object))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.bottom, 6)
//                }
//            }
        }
        .overlay {
            if infoObjects.isEmpty {
                ContentUnavailableView {
                    Label("Nothing saved yet", systemImage: "pawprint")
                }
            }
        }
    }
    
}

struct DateSectionHeaderView: View {
    var group: (date: Date, infoObjects: [InfoObject])
    
    var body: some View {
        Text(formattedDate(group.date))
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
    
    // Helper for formatting dates
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
//    let userData = UserDataManager()
    InfoObjectsGridView(selectedCategories: [], selectedType: .all)
        .modelContainer(previewContainer)
}
