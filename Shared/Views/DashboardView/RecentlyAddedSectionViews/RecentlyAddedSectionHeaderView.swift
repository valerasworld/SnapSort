//
//  RecentlyAddedSectionHeaderView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct RecentlyAddedSectionHeaderView: View {
    
    var userData: UserDataManager
    
    var body: some View {
        HStack {
            NavigationLink {
//                InfoObjectsListView(infoObjects: userData.objects.reversed())
            } label: {
                HStack {
                    Text("Recently Added") // Link to Timeline
                        .foregroundStyle(Color("black"))
                        .font(.title)
                        .bold()
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .bold()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
        
    }
}
