//
//  InfoObjectListViewMainScreenView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/05/25.
//

import SwiftUI

struct InfoObjectListViewMainScreenView: View {
    
    var userData: UserDataManager
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var groupedByDateObjects: [(date: Date, infoObjects: [InfoObject])] {
        let groupedDictionary = Dictionary(grouping: userData.objects) { infoObject in
            (infoObject.dateAdded).startOfDay()
        }
        return groupedDictionary
            .map { ($0.key, $0.value) }
            .sorted { $0.0 > $1.0 }
    }
    
    var body: some View {
        ScrollView {
            ForEach(groupedByDateObjects, id: \.date) { group in
                Section(header: DateSectionHeaderView(group: group)) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(group.infoObjects, id: \.self) { object in
//                            InfoObjectCardView(infoObject: object, previewMode: .category)
                            NewVerticalInfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: object))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.bottom, 6)
                }
            }
//            .navigationTitle(category?.rawValue.capitalized ?? "Timeline")
        }
//        .background {
//            VStack {
//                ForEach(userData.findUniqueCategories(), id: \.self) { category in
//                    Circle()
//                        .foregroundStyle(category.color)
//                }
//            }
//            .foregroundStyle(.ultraThinMaterial)
//            .ignoresSafeArea()
//            
//        }
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
    let userData = UserDataManager()
    InfoObjectListViewMainScreenView(userData: userData)
}
