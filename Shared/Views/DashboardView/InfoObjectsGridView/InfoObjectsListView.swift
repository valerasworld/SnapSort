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
    var gridPadding: CGFloat = 12
    

    
    var body: some View {
        ScrollView {
            ForEach(userData.groupedObjects, id: \.date) { group in
                Section(header: DateSectionHeaderView(group: group)) {
                    LazyVGrid(columns: columns) {
                        ForEach(group.infoObjects, id: \.self) { object in
                            InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: object), gridPadding: gridPadding)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    Spacer().frame(height: 20)
                }
            }
        }
    }
    
}

#Preview {
    let userData = UserDataManager()
    InfoObjectsListView(userData: userData)
}
