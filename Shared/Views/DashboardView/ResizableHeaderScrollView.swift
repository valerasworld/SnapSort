//
//  ResizableHeaderScrollView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 22/05/25.
//

import SwiftUI

struct ResizableHeaderScrollView<Header: View, StickyHeader: View, CategoryFilter: View, Background: View, Content: View>: View {
    
    var spacing: CGFloat = 8
    @ViewBuilder var header: Header
    @ViewBuilder var stickyHeader: StickyHeader
    @ViewBuilder var categoryFilter: CategoryFilter
    // Only for header background, not for the entire View
    @ViewBuilder var background: Background
    @ViewBuilder var content: Content
    
    // View Properties:
    @State var currentDragOffset: CGFloat = 0
    @State var previousDragOffset: CGFloat = 0
    @State var headerOffset: CGFloat = 0
    @State var headerSize: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical) {
            content
        }
        .frame(maxWidth: .infinity)
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y + $0.contentInsets.top
        }, action: { _, newValue in
            scrollOffset = newValue
        })
        .simultaneousGesture(
            DragGesture(minimumDistance: 10)
                .onChanged({ value in
                    // Adjusting the minimum distance value
                    // Thus it starts from 0.
                    let dragOffset = -max(0, abs(value.translation.height) - 50) * (value.translation.height < 0 ? -1 : 1)
                    
                    previousDragOffset = currentDragOffset
                    currentDragOffset = dragOffset
                    
                    let deltaOffset = (currentDragOffset - previousDragOffset).rounded()
                    
                    headerOffset = max(min(headerOffset + deltaOffset, headerSize), 0)
                }).onEnded({ _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if headerOffset > (headerSize * 0.5) && scrollOffset > headerSize {
                            headerOffset = headerSize
                        } else {
                            headerOffset = 0
                        }
                    }
                    
                    // Resetting offset data
                    currentDragOffset = 0
                    
                })
        )
        .safeAreaInset(edge: .top, spacing: spacing) {
            CombinedHeaderView()
        }
    }
    
    @ViewBuilder
    private func CombinedHeaderView() -> some View {
        VStack(spacing: spacing) {
            header
                .onGeometryChange(for: CGFloat.self) {
                    $0.size.height
                } action: { newValue in
                    // Optional "spacing"
                    headerSize = newValue/* + spacing*/
                }

            stickyHeader
            categoryFilter
        }
//        .offset(y: -headerOffset)
//        .clipped()
        .background {
            background
                .ignoresSafeArea()
        }
        
    }
}

//#Preview {
//    ResizableHeaderScrollView()
//}
