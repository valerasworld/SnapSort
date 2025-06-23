//
//  CreateNewCategorySheetHeaderView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//


import SwiftUI

struct CreateNewCategorySheetHeaderView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text("Add New Category")
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer(minLength: 0)
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
            }
        }
    }
}
