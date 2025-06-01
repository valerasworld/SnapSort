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
    InfoObjectCardView(viewModel: InfoObjectCardViewModel(infoObject: SampleObjects.contents.first!))
}

private struct InfoCardImageLayerView: View {
    
    var infoObject: InfoObject
    
    var width: CGFloat
    var gridPadding: CGFloat
    var padding: CGFloat
    
    var body: some View {
        ZStack {
            if let image = infoObject.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
            } else {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        ZStack {
                            Rectangle()
                                .fill(infoObject.category.color)
                            Rectangle()
                                .fill(.ultraThinMaterial)
                        }
                    )
            }
            Color.black.opacity(0.02)
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
            .lineLimit(1)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.black)
            
            Group {
                if let stringURL = infoObject.stringURL {
                    Text(URL(string: stringURL)?.host?.replacingOccurrences(of: "www.",with: "") ?? "")
                        .foregroundStyle(.black.opacity(0.6))
                } else {
                    Text("www.com")
                        .opacity(0)
                }
            }
            .font(.footnote)
            .lineLimit(1)
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

private struct InfoCardBookmarkView: View {
    
    var category: Category
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    ZStack {
                        Rectangle()
                            .fill(category.color)
                        
                        Rectangle()
                            .fill(.ultraThinMaterial)
                    })
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
        .frame(width: 30)
        .roundedCorners(10, corners: [.bottomLeft, .bottomRight])
        .padding(.bottom, 8)
    }
}
