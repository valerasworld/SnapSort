//
//  IconPickerView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//


import SwiftUI

struct IconPickerView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    @Binding var selectedIconName: String
    @Binding var selectedCategoryColorName: String
    
    var iconGroups: [[String]] {
        let allIcons = IconData.iconNames
        let groupSize = 18

       return stride(from: 0, to: allIcons.count, by: groupSize).map {
            Array(allIcons[$0..<min($0 + groupSize, allIcons.count)])
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var activeIndex: Int? = 0
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(iconGroups.indices, id: \.self) { index in
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(iconGroups[index], id: \.self) { iconName in
                                IconPickerLabel(iconName: iconName, selectedIconName: $selectedIconName, selectedCategoryColorName: $selectedCategoryColorName)
                                    .padding(2)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            selectedIconName = iconName
                                        }
                                    }
                            }
                        }
                        .onChange(of: activeIndex) { _, newValue in
                            withAnimation(.easeInOut) {
                                activeIndex = newValue
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.horizontal, alignment: .center)
                        .id(index)
                        
                    }
                }
            }
            .scrollClipDisabled()
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            
            .scrollIndicators(.hidden)
            .scrollPosition(id: $activeIndex, anchor: .center)
            
            HStack(spacing: 4) {
                ForEach(iconGroups.indices, id: \.self) { index in
                    Circle()
                        .frame(width: 5)
                        .scaleEffect(index == activeIndex ? 1 : 0.8)
                        .opacity(index == activeIndex ? 0.9 : 0.5)
                }
            }
        }
        .padding(.bottom, 5)
    }
}


