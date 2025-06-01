//
//  SwiftUIView.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 09/05/25.
//

import SwiftUI

struct DetailedPhotoItemView: View {
    let viewModel: InfoObjectCardViewModel
    
    var body: some View {
        ScrollView {
 
            VStack(alignment: .leading, spacing: 12) {
                ZStack(alignment: .bottomLeading) {
                    if viewModel.infoObject.image != nil {
                        if let uiImage = viewModel.infoObject.image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            Color.black.opacity(0.03)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.gray)
                        }
                    }
                    if viewModel.infoObject.stringURL != nil {
                        LinkButtonOnDetailView(infoObject: viewModel.infoObject)
                    }
                    
                    
                    
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.infoObject.title ?? "")
                        .foregroundStyle(.black)
                        .font(.title)
                        .bold()
                    
//                    Text(viewModel.infoObject.description ?? "")
//                        .foregroundStyle(.black)
//                        .font(.body)
                    
                    TagsView(tags: viewModel.infoObject.tags)
                }
                .padding(.horizontal)
            }
            .overlay {
                
            }
        }
        
    }
}

#Preview {
    DetailedPhotoItemView(viewModel: InfoObjectCardViewModel(infoObject: SampleObjects.contents.first!))
}

struct LinkButtonOnDetailView: View {
    var infoObject: InfoObject
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "link")
                Text(URL(string: infoObject.stringURL ?? " ")?.host?.replacingOccurrences(of: "www.", with: "") ?? "")
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .font(.body)
            .bold()
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(infoObject.category.color)
            }
            .padding()
        }
        
    }
}
