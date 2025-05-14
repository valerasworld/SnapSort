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
    var previewMode: LinkPreviewMode = .dashboard
    var cornerRadius: CGFloat = 10
    var padding: CGFloat = 16
    @State var showProgressView: Bool = true
    
    @Bindable var infoObject: InfoObject
    @State var presentSheet: Bool = false
    
    var body: some View {
        let bgColor = viewModel.infoObject.category.color
        
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(bgColor.gradient)

            
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .top) {
                    if viewModel.infoObject.stringURL != nil {
                        if let image = infoObject.image {
                            InfoObjectCardImageLayerView(image: image, cornerRadius: cornerRadius, color: bgColor)
                        } else {
                            if showProgressView {
                                ProgressView()
                                    .tint(.white)
                            }
                        }
                    }
                }
                .frame(width: 200, height: 113)
                .frame(maxWidth: 300)
                Spacer()
                
                
            }
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                VStack(alignment: .leading) {
                    Text(infoObject.title ?? "")
                        .font(.subheadline)
                        .bold()
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.white/*bgColor.isLight() ? .black : .white*/)
                    
                    Text(URL(string: infoObject.stringURL ?? " ")?.host?.replacingOccurrences(of: "www.", with: "") ?? "")
                        .foregroundStyle(.white.opacity(0.8))
                        .font(.footnote)
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, padding)
                .padding(.vertical, 8)
                .background {
                    Rectangle()
                        .foregroundStyle(bgColor)
                        .roundedCorners(cornerRadius, corners: [.bottomLeft, .bottomRight])
                        .frame(maxWidth: .infinity)
                }
//                .opacity(0.1)
            }
            
            
        }
        .frame(width: 200, height: 165)
        
        .onAppear {
            Task {
                do {
                    showProgressView = true
                    
                    try await viewModel.loadPreview()
                    if infoObject.image != nil {
                        showProgressView = false
                    }
                } catch let error {
                    print("Error: \(error)")
                }
                
            }
            
        }
        .onTapGesture {
            presentSheet.toggle()
        }
        .sheet(isPresented: $presentSheet) {
            DetailedItemView(infoObject: infoObject)
        }
    }
}

#Preview {
//    @Previewable
//    @State var infoObject = InfoObject(
//        title: "iPhone",
//        author: "J.K. Rowling",
//        stringURL: "https://www.apple.com/iphone/",
//        //        stringURL: "https://www.linkedin.com/",
//        category: .books,
//        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
//    )
        @Previewable
        @State var infoObject2 = InfoObject(
            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3",
            category: .memes,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        )
    //    @Previewable
    //    @State var infoObject3 = InfoObject(
    //        title: "Harry Potter",
    //        author: "J.K. Rowling",
    //        stringURL: "https://music.apple.com/ru/album/no-surprise/1763707129?i=1763707240&l=en-GB",
    //        category: .restaurants,
    //        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    //    )
    VStack {
        Spacer()
        InfoObjectCardCustomView(viewModel: .init(infoObject: infoObject2), infoObject: infoObject2)
        Spacer()
        InfoObjectCardView(infoObject: infoObject2)
        Spacer()
        //        InfoObjectCardCustomView(viewModel: .init(infoObject: infoObject2))
        //        Spacer()
        //        InfoObjectCardCustomView(viewModel: .init(infoObject: infoObject3))
        //        Spacer()
    }
}

struct InfoObjectCardImageLayerView: View {
    var image: UIImage
    var cornerRadius: CGFloat
    var color: Color
    
    var body: some View {
//        Image(uiImage: image)
//            .resizable()
//            .scaledToFill()
//            .frame(width: 200, height: 113)
//            .frame(maxWidth: 300)
//            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
//        
//        Color.black.opacity(0.5)
//            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
//        
//        Color(color).opacity(0.1)
//            .background(.ultraThinMaterial)
//            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
        
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 113)
            .frame(maxWidth: 300)
            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
 
        Color.black
            .opacity(0.03)
            .roundedCorners(cornerRadius, corners: [.topLeft, .topRight])
    }
}
