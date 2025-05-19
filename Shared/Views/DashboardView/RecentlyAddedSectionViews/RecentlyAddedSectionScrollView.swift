//
//  RecentlyAddedSectionScrollView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct RecentlyAddedSectionScrollView: View {
    
    var userData: UserData
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(userData.objects, id: \.self) { object in
//                    InfoObjectCardView(infoObject: object, previewMode: .dashboard)
//                        .frame(maxWidth: .infinity, alignment: .leading)
                    InfoObjectCardCustomView(viewModel: InfoObjectCardViewModel(infoObject: object))
                }
                
            }
            .padding()
        }
        .frame(height: 130)
        .padding(.vertical)
        .padding(.bottom, 4)
    }
}
