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
                    
                    Text(viewModel.infoObject.description ?? "")
                        .foregroundStyle(.black)
                        .font(.body)
                    
                    TagsView(infoObject: viewModel.infoObject)
                }
                .padding(.horizontal)
            }
            .overlay {
                
            }
        }
        
    }
}

#Preview {
    @Previewable
    @State var infoObject = InfoObject(
        title: "Among Us",
        description: "Lore ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum. Nam viverra fringilla erat, ut fermentum nunc feugiat eu.",
        image: UIImage(named: "amongUs"),
        stringURL: "https://www.apple.com/iphone/",
        tags: ["Multiplayer", "Party game", "Online game"],
        category: .electronics,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    
    var viewModel = InfoObjectCardViewModel(infoObject: infoObject)
    
    DetailedPhotoItemView(viewModel: viewModel)
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
