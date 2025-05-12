//
//  InfoObjectCardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//

import SwiftUI
import LinkPresentation

struct InfoObjectCardView: View {
    
    @Bindable var infoObject: InfoObject
    var previewMode: LinkPreviewMode = .dashboard
    
    var body: some View {
        
        // if there's a link preview then showing it...
        // else show loading...
        // otherwise show general card view...
        Group {
            if infoObject.previewLoading {
                if let metadata = infoObject.linkMetaData {
                    // Link Preview...
                    switch previewMode {
                    case .dashboard:
                        LinkPreview(metadata: metadata, fixedWidth: 200, fixedHeight: 200)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 250, maxHeight: 200)
                    case .category:
                        LinkPreview(metadata: metadata, fixedWidth: 100)
                    }
                    
                } else {
                    // Progress View...
                    HStack(spacing: 10) {
                        
                        // Showing URL Host only...
                        Text(infoObject.linkURL?.host ?? "")
                            .font(.caption)
                        
                        ProgressView()
                            .tint(infoObject.category.color)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.35))
                    .cornerRadius(10)
                    .frame(width: 250, height: 200, alignment: .bottomLeading)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
            } else {
                // General Card View...
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(infoObject.category.color)
                    
                    Text(infoObject.title ?? "")
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            
            
        }
//        .frame(maxHeight: previewMode == .dashboard ? 200 : 500)
        .onAppear {
            Task {
                do {
                    try await loadPreview()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func loadPreview() async throws {
        // This already handles URL validity
        guard let stringURL = infoObject.stringURL,
              let url = URL(string: stringURL),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        infoObject.previewLoading = true
        infoObject.linkURL = url
        
        let provider = LPMetadataProvider()
        do {
            let metadata = try await provider.startFetchingMetadata(for: url)
            infoObject.linkMetaData = metadata
        } catch {
            print(error)
        }
    }
}

#Preview {
    @Previewable
    @State var infoObject = InfoObject(
        title: "Harry Potter",
        author: "J.K. Rowling",
        stringURL: "https://www.apple.com/iphone/",
        category: .books,
        dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
    )
    InfoObjectCardView(infoObject: infoObject)
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
