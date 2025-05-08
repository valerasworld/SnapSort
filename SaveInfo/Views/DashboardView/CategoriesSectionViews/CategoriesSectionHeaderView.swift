//
//  CategoriesSectionHeaderView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct CategoriesSectionHeaderView: View {
    var body: some View {
        HStack {
            Text("Categories")
                .font(.title)
                .bold()
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
