//
//  NewVerticalInfoObjectCardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 22/05/25.
//

import SwiftUI

struct NewVerticalInfoObjectCardView: View {
    
    @State var viewModel: InfoObjectCardViewModel
    @State var presentSheet: Bool = false
    @State var gridPadding: CGFloat = 12
//    @State var glassOpacity: Double = 100
    
    var body: some View {
        let width = UIScreen.main.bounds.width / 2
        VStack(spacing: 0) {
            // Image
            ZStack {
                if let image = viewModel.infoObject.image {
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
                                    .fill(viewModel.infoObject.category.color)
//                                Text("Text")
//                                    .font(.largeTitle)
//                                    .bold()
                                Rectangle()
                                    .fill(.ultraThinMaterial)
//                                    .opacity(glassOpacity)
                            }
                        )
//                        .onAppear {
//                            withAnimation(.spring(duration: 7)) {
//                                glassOpacity = 0
//                            }
//                        }
                }
                Color.black.opacity(0.02)
            }
            .aspectRatio(CGSize(width: width, height: width / 16 * 9), contentMode: .fill)
            .frame(
                maxWidth: width - gridPadding * 1.5 - viewModel.padding / 2,
                maxHeight: (width - gridPadding * 1.5 - viewModel.padding / 2) / 16 * 9
            )
//            .padding()
            
            // Text BLOCK
            ZStack {
                Color.white
                HStack(alignment: .top, spacing: 6) {
                    // Text Layer
                    VStack(alignment: .leading) {
                        Group {
                            if let title = viewModel.infoObject.title {
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
                        
                            
                        //                    .foregroundStyle(.white/*bgColor.isLight() ? .black : .white*/)
                            .foregroundStyle(.black/*bgColor.isLight() ? .black : .white*/)
                        Group {
                            if let stringURL = viewModel.infoObject.stringURL {
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
                    
                    // Bookmark
                    ZStack(alignment: .bottom) {
//                        Rectangle()
//                            .foregroundStyle(viewModel.infoObject.category.color)
                        Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(viewModel.infoObject.category.color)
                                
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                            })
                        VStack {
                            Spacer()
                            Image(systemName: viewModel.infoObject.category.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(.white)
//                                .foregroundStyle(.black)
//                                .foregroundStyle(viewModel.infoObject.category.color)
                                .bold()
                            Spacer()
                                
                        }
                        
                    }
                    .frame(width: 30)
                    .roundedCorners(10, corners: [.bottomLeft, .bottomRight])
                    .padding(.bottom, 8)
                }
                .padding(.horizontal, viewModel.padding)
            }
                
        }
        .roundedCorners(10, corners: .allCorners)
//        .padding(.horizontal)
//        .frame(width: width - gridPadding / 2)
//        .frame(maxWidth: width - gridPadding / 2)
        .frame(maxWidth: width - gridPadding * 1.5 - viewModel.padding / 2)
        .shadow(color: .black.opacity(0.17), radius: 5, x: 0, y: 0)
        
        .onAppear {
            Task {
                try? await viewModel.loadPreview()
            }
        }
        .onTapGesture {
            presentSheet.toggle()
        }
        .sheet(isPresented: $presentSheet) {
            DetailedItemView(infoObject: viewModel.infoObject)
        }
        
        
    }
}


#Preview {
    let infoObject2 = InfoObject(
        title: "Harry Potter",
        author: "J.K. Rowling",
        stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3",
        category: .memes,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    let objects: [InfoObject] = Array(repeating: infoObject2, count: 4)
    
    let viewModel = InfoObjectCardViewModel(infoObject: infoObject2)
    
    return ZStack {
        Color.gray.opacity(0.1)
            .ignoresSafeArea()
        LazyVGrid(columns: columns/*, spacing: 6*/) {
            
            NewVerticalInfoObjectCardView(viewModel: viewModel)
            NewVerticalInfoObjectCardView(viewModel: viewModel)
            NewVerticalInfoObjectCardView(viewModel: viewModel)
            NewVerticalInfoObjectCardView(viewModel: viewModel)
            
            
        }
        .padding(.horizontal)
    }
    
}

