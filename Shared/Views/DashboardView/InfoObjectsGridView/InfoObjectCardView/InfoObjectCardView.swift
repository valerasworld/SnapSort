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
    
    var body: some View {
        NavigationLink(destination: DetailedItemView(infoObject: viewModel.infoObject)) {
            
            let width = UIScreen.main.bounds.width / 2
            
            VStack(spacing: 0) {
                // Image Block
                InfoCardImageLayerView(
                    infoObject: viewModel.infoObject,
                    width: width,
                    gridPadding: gridPadding,
                    padding: padding
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
    
    var hasImage: Bool {
        if infoObject.image != nil {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = infoObject.image {
                //            if let imageData = infoObject.image,
                //                let uiImage = UIImage(data: imageData) {
                ZStack {
                    Image(uiImage: image)
                    //                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                    Color.black.opacity(0.02)
                }
                
            } else {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        Rectangle()
                            .fill(infoObject.category.color)
                    )
            }
            
            
        }
        .aspectRatio(16/9, contentMode: .fill)
        .frame(
            maxWidth: width - gridPadding * 1.5 - padding / 2,
            maxHeight: (width - gridPadding * 1.5 - padding / 2) / 16 * 9
        )
        .overlay {
            HStack {
                Spacer()
                VStack {
                    if infoObject.isFavorite {
                        ZStack {
                            Color(infoObject.category.color)
                            if !hasImage {
                                Color.clear
                                    .background(.ultraThinMaterial)
                            }
                        }
                        .mask {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        }
                        .frame(width: 18, height: 18)
                        .padding()
                        .padding(.horizontal, 0)
                        .shadow(color: (hasImage ? Color.white.opacity(0.17) : Color.black.opacity(0.17)), radius: 5)
                    }
                    Spacer()
                }
            }
        }
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
