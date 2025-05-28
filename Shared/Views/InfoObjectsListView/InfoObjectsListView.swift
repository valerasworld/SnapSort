//
//  InfoObjectsListView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct InfoObjectsListView: View {
    
    var userData: UserDataManager
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var groupedObjects: [(date: Date, infoObjects: [InfoObject])] {
        let groupedDictionary = Dictionary(grouping: userData.objects) { infoObject in
            (infoObject.dateAdded).startOfDay()
        }
        return groupedDictionary
            .map { ($0.key, $0.value) }
            .sorted { $0.0 > $1.0 }
    }
    
    var body: some View {
        ScrollView {
            ForEach(groupedObjects, id: \.date) { group in
                Section(header: DateSectionHeaderView(group: group)) {
                    LazyVGrid(columns: columns) {
                        ForEach(group.infoObjects, id: \.self) { object in
//                            InfoObjectCardView(infoObject: object, previewMode: .category)
                            NewVerticalInfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: object))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    Spacer().frame(height: 20)
                }
            }
//            .navigationTitle(category?.rawValue.capitalized ?? "Timeline")
        }
    }
    
}

//struct DateSectionHeaderView: View {
//    var group: (date: Date, infoObjects: [InfoObject])
//    
//    var body: some View {
//        Text(formattedDate(group.date))
//            .font(.title2)
//            .bold()
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.leading)
//    }
//    
//    // Helper for formatting dates
//    func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: date)
//    }
//}

#Preview {
    let userData = UserDataManager()
    InfoObjectsListView(userData: userData)
}
