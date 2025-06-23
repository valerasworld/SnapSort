//
//  NewVerticalInfoObjectCardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 22/05/25.
//

import SwiftUI
import SwiftData

struct InfoObjectCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    @State var cardViewModel: InfoObjectCardViewModel
    @State var gridPadding: CGFloat = 12
    @State var padding: CGFloat = 16
    
    var dashboardViewModel: DashboardViewModel
    
    var hasImage: Bool {
        if cardViewModel.infoObject.image != nil {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationLink(destination: DetailedItemView(infoObject: cardViewModel.infoObject, dashboardViewModel: dashboardViewModel)) {
            
            let width = UIScreen.main.bounds.width / 2
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    // Image Block
                    InfoCardImageLayerView(
                        infoObject: cardViewModel.infoObject,
                        width: width,
                        gridPadding: gridPadding,
                        padding: padding,
                        hasImage: hasImage
                    )
                    
                    // Lower Block
                    ZStack {
                        colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1))
                        HStack(alignment: .top, spacing: 6) {
                            InfoCardTextLayerView(infoObject: cardViewModel.infoObject)
                            InfoCardBookmarkView(category: cardViewModel.infoObject.category)
                        }
                        .padding(.horizontal, padding)
                    }
                    
                    
                }
                .roundedCorners(10, corners: .allCorners)
                .frame(maxWidth: width - gridPadding * 1.5 - padding / 2)
                .shadow(color: .black.opacity(0.17), radius: 5, x: 0, y: 0)
                
                if cardViewModel.infoObject.isFavorite {
                    ZStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(cardViewModel.infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme))
                            .shadow(color: (hasImage ? (colorScheme == .light ? Color.black.opacity(0.17) : Color.white.opacity(0.17)) : Color.clear), radius: 5)
                            .font(.title3)
                        
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(colorScheme == .light ? .white : .black)
                    }
                    .frame(width: 20, height: 20)
                    .padding()
                    .padding(.horizontal, 0)
                    
                }
            }
            .onAppear {
                Task {
                    guard !cardViewModel.infoObject.hasMetadata else {
                        return
                    }
                    try? await cardViewModel.loadPreview()
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
    
    InfoObjectCardView(cardViewModel: InfoObjectCardViewModel(infoObject: infoObject), dashboardViewModel: DashboardViewModel())
    InfoObjectCardView(cardViewModel: InfoObjectCardViewModel(infoObject: infoObject), dashboardViewModel: DashboardViewModel())
    
}

private struct InfoCardImageLayerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
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
                        .fill(infoObject.category.color(for: userData.colorTheme, colorScheme: colorScheme))
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
                            .tint(colorScheme == .light ? .white : .black)
                    }
                }
                
            }
        }
        .aspectRatio(16/9, contentMode: .fill)
        .frame(
            maxWidth: width - gridPadding * 1.5 - padding / 2,
            maxHeight: (width - gridPadding * 1.5 - padding / 2) / 16 * 9
        )
        .clipped()
        
    }
}

private struct InfoCardTextLayerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
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
            .foregroundStyle(colorScheme == .light ? .black : .white)
            
            if hasLink {
                Group {
                    if let stringURL = infoObject.stringURL {
                        Text(URL(string: stringURL)?.host?.replacingOccurrences(of: "www.",with: "") ?? "")
                        
                            .foregroundStyle(colorScheme == .light ? .black.opacity(0.6) : .white.opacity(0.6))
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


