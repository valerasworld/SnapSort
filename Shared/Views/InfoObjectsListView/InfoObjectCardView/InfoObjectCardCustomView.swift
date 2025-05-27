//
//  InfoObjectCardCustomView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 09/05/25.
//

import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

struct InfoObjectCardCustomView: View {
    
    @State var viewModel: InfoObjectCardViewModel
    @State var presentSheet: Bool = false
    
    var body: some View {
        let bgColor = viewModel.infoObject.category.color
        let cornerRadius = viewModel.cornerRadius
        
//        ZStack(alignment: .bottomLeading) {
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .foregroundStyle(bgColor.gradient)
//
//            
//            VStack(alignment: .leading, spacing: 0) {
//                ZStack(alignment: .top) {
//                    if viewModel.infoObject.stringURL != nil {
//                        if let image = viewModel.infoObject.image {
//                            InfoObjectCardImageLayerView(image: image, cornerRadius: cornerRadius, color: bgColor)
//                        } else {
//                            if viewModel.previewLoading {
//                                ProgressView()
//                                    .tint(.white)
//                            }
//                        }
//                    }
//                }
//                .frame(width: 200, height: 113)
//                .frame(maxWidth: 300)
//                Spacer()
//                
//                
//            }
//            InfoObjectCardTextLayerView(viewModel: viewModel)
        
//        ZStack(alignment: .bottomLeading) {
//            RoundedRectangle(cornerRadius: viewModel.cornerRadius + 2)
//                .foregroundStyle(viewModel.infoObject.category.color)
//
//            Group {
//                RoundedRectangle(cornerRadius: viewModel.cornerRadius)
//                    .foregroundStyle(.white)
//                VStack(alignment: .leading, spacing: 0) {
//                    ZStack(alignment: .top) {
//                        if viewModel.infoObject.stringURL != nil {
//                            if let image = viewModel.infoObject.image {
//                                InfoObjectCardImageLayerView(image: image, cornerRadius: viewModel.cornerRadius + 2, color: bgColor)
////                                    .padding(.horizontal)
////                                    .padding(.top)
////                                    .mask {
////                                        RoundedRectangle(cornerRadius: cornerRadius)
////                                    }
//                            } else {
//                                if viewModel.previewLoading {
//                                    ProgressView()
//                                        .tint(.white)
//                                }
//                            }
//                        }
//                    }
//                    .padding(2)
//                    .frame(width: 200, height: 113)
//                    .frame(maxWidth: 300)
//                    Spacer()
//                    
//                    
//                }
//                InfoObjectCardTextLayerView(viewModel: viewModel)
//            }
//            .padding(2)
        
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: viewModel.cornerRadius + 1)
                .foregroundStyle(Color.black)

            Group {
                RoundedRectangle(cornerRadius: viewModel.cornerRadius)
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 0) {
                    ZStack(alignment: .top) {
                        if viewModel.infoObject.stringURL != nil {
                            if let image = viewModel.infoObject.image {
                                InfoObjectCardImageLayerView(infoObject: viewModel.infoObject, image: image, cornerRadius: viewModel.cornerRadius + 2, color: bgColor)
//                                    .padding(.horizontal)
//                                    .padding(.top)
//                                    .mask {
//                                        RoundedRectangle(cornerRadius: cornerRadius)
//                                    }
                            } else {
                                if viewModel.previewLoading {
                                    ProgressView()
                                        .tint(.white)
                                }
                            }
                        }
                    }
                    .padding(1)
                    .frame(width: 200, height: 113)
                    .frame(maxWidth: 300)
                    Spacer()
                    
                    
                }
                InfoObjectCardTextLayerView(viewModel: viewModel)
                    .overlay {
                        ZStack {
                            Rectangle()
                                .roundedCorners(cornerRadius - 1, corners: [.bottomLeft, .bottomRight])
                                .foregroundStyle(viewModel.infoObject.category.color)
                                .shadow(radius: 4)
                            VStack {
                                Spacer()
                                Image(systemName: viewModel.infoObject.category.iconName)
                                    .foregroundStyle(.white)
                            }
                            .padding(5)
                            
                        }
                        .frame(width: 30, height: 40)
                        .offset(x: 70, y: 49)
                    }
            }
            .padding(1)
            
        }
        .frame(width: 200, height: 165)
        
        .onAppear {
            Task {
                try? await viewModel.loadPreview()
            }
        }
        .onTapGesture {
            presentSheet.toggle()
        }
        .sheet(isPresented: $presentSheet) {
            DetailedPhotoItemView(viewModel: viewModel)
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
    
    let viewModel = InfoObjectCardViewModel(infoObject: infoObject2)
    
    return VStack {
        Spacer()
        InfoObjectCardCustomView(viewModel: viewModel)
        Spacer()
        InfoObjectCardView(infoObject: infoObject2)
        Spacer()
    }
}

struct InfoObjectCardImageLayerView: View {
    var infoObject: InfoObject
    var image: UIImage
    var cornerRadius: CGFloat
    var color: Color
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 113)
            .frame(maxWidth: 300)
            .roundedCorners(cornerRadius - 2, corners: [.topLeft, .topRight])
 
        Color.black
            .opacity(0.03)
            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
        
        
        
            
            
    }
}

struct InfoObjectCardTextLayerView: View {
    var viewModel: InfoObjectCardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            VStack(alignment: .leading) {
                Text(viewModel.infoObject.title ?? "")
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
//                    .foregroundStyle(.white/*bgColor.isLight() ? .black : .white*/)
                    .foregroundStyle(.black/*bgColor.isLight() ? .black : .white*/)
                
                Text(URL(string: viewModel.infoObject.stringURL ?? " ")?.host?.replacingOccurrences(of: "www.", with: "") ?? "")
                    .foregroundStyle(.black.opacity(0.6))
                    .font(.footnote)
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, viewModel.padding)
            .padding(.vertical, 8)
            .background {
                Rectangle()
//                    .foregroundStyle(viewModel.infoObject.category.color)
                    .foregroundStyle(.white)
                    .roundedCorners(viewModel.cornerRadius, corners: [.bottomLeft, .bottomRight])
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
