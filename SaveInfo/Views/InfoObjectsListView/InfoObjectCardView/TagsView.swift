//
//  TagsView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct TagsView: View {
    
    var infoObject: InfoObject
    
    var body: some View {
        ScrollView([.horizontal]) {
            HStack {

                ForEach(infoObject.tags, id: \.self) { tag in
                    
                    Text(tag.capitalized)
                    
                
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.12), radius: 10)
                    }
                }
                
                Spacer()
                    .frame(width: 15)
            }
            .padding(.vertical, 10)
            
        }
        .scrollIndicators(.hidden)
    }
}
