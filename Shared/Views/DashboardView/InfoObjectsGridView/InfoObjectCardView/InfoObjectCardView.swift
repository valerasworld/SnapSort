//
//  NewVerticalInfoObjectCardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 22/05/25.
//

import SwiftUI

struct InfoObjectCardView: View {
    
    @State var viewModel: InfoObjectCardViewModel
    @State var gridPadding: CGFloat = 12
    @State var padding: CGFloat = 16
    
    var hasImage: Bool {
        if viewModel.infoObject.image != nil {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationLink(destination: DetailedItemView(infoObject: viewModel.infoObject)) {
            
            let width = UIScreen.main.bounds.width / 2
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    // Image Block
                    InfoCardImageLayerView(
                        infoObject: viewModel.infoObject,
                        width: width,
                        gridPadding: gridPadding,
                        padding: padding,
                        hasImage: hasImage
                    )
                    
                    // Lower Block
                    ZStack {
                        Color.white
                        HStack(alignment: .top, spacing: 6) {
                            InfoCardTextLayerView(infoObject: viewModel.infoObject)
                            InfoCardBookmarkView(category: viewModel.infoObject.category)
                        }
                        .padding(.horizontal, padding)
                    }
                    
                    
                }
                .roundedCorners(10, corners: .allCorners)
                .frame(maxWidth: width - gridPadding * 1.5 - padding / 2)
                .shadow(color: .black.opacity(0.17), radius: 5, x: 0, y: 0)
                
                if viewModel.infoObject.isFavorite {
                    ZStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(viewModel.infoObject.category.color)
                            .shadow(color: (hasImage ? Color.black.opacity(0.17) : Color.clear), radius: 5)
                            .font(.title3)
                            
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                    }
                    .frame(width: 20, height: 20)
                    .padding()
                    .padding(.horizontal, 0)
                    
                }
            }
            .onAppear {
                Task {
                    try? await viewModel.loadPreview()
                }
            }
        }
    }
}


#Preview {
    
    let infoObject: InfoObject = InfoObject(
        //        title: "Hello",
        title: "Hello, here's a hyperpigmentation",
        //        stringURL: "https://www.test.com",
        category: Category(
            name: "Memes",
            colorName: "red",
            iconName: "bookmark.fill"
        )
    )
    
    InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: /*SampleObjects.contents.last!*/ infoObject))
    InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: /*SampleObjects.contents.last!*/ infoObject))
    
}

private struct InfoCardImageLayerView: View {
    
    var infoObject: InfoObject
    
    var width: CGFloat
    var gridPadding: CGFloat
    var padding: CGFloat
    
    var hasImage: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Rectangle()
                        .fill(infoObject.category.color)
                )
            
            if infoObject.stringURL != nil {
                if let image = infoObject.image {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        Color.black.opacity(0.02)
                    }
                } else {
                    if infoObject.previewLoading {
                        ProgressView()
                            .tint(.white)
                    }
                }
                
            }
            
            
            
            
        }
        .aspectRatio(16/9, contentMode: .fill)
        .frame(
            maxWidth: width - gridPadding * 1.5 - padding / 2,
            maxHeight: (width - gridPadding * 1.5 - padding / 2) / 16 * 9
        )
        
    }
}

private struct InfoCardTextLayerView: View {
    
    var infoObject: InfoObject
    
    var hasLink: Bool {
        guard let stringURL = infoObject.stringURL else { return false }
        
        if stringURL == "" || stringURL == " " {
            return false
        }
        return true
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let title = infoObject.title {
                    Text(title)
                } else {
                    Text("No Text")
                        .opacity(0)
                }
            }
            .font(.subheadline)
            .bold()
            .lineLimit(hasLink ? 1 : 2)
            .multilineTextAlignment(.leading)
            .lineSpacing(hasLink ? 0 : -2)
            .foregroundStyle(.black)
            
            if hasLink {
                Group {
                    if let stringURL = infoObject.stringURL {
                        Text(URL(string: stringURL)?.host?.replacingOccurrences(of: "www.",with: "") ?? "")
                        
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .font(.footnote)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

struct InfoCardBookmarkView: View {
    
    var category: Category
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.clear)
                .background(Rectangle().fill(category.color))
            
            VStack {
                Spacer()
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
                
            }
            
        }
        .frame(width: 30, height: 44)
        .roundedCorners(10, corners: [.bottomLeft, .bottomRight])
        .padding(.bottom, 8)
    }
}
