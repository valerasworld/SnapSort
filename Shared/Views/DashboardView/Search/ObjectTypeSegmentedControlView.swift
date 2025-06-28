//
//  ObjectTypeSegmentedControlView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI
import SwiftData

struct ObjectTypeSegmentedControlView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    @Environment(\.uniqueCategories) var uniqueCategories
    
    var viewModel: DashboardViewModel
    @Namespace private var animation
    
    var style: SegmentedControlStyleProvider {
        .init(
            userData: userData,
            colorScheme: colorScheme,
            uniqueCategories: uniqueCategories,
            selectedCategories: viewModel.selectedCategories,
            infoObjects: viewModel.infoObjects,
            availableTypes: viewModel.availableTypes,
            selectedType: viewModel.selectedType
        )
    }
        
    var body: some View {
        HStack(spacing: 10) {
            ForEach(viewModel.availableTypes, id: \.self) { type in
                Button {
                    withAnimation(.snappy) {
                        viewModel.selectedType = type
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                } label: {
                    Text(type.typeName)
                        .foregroundStyle(style.textColor(for: type))
                        .cornerRadius(10)
                        .fontWeight(.semibold) // ??
                        .padding(.horizontal, 20)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .background {
                            if viewModel.selectedType == type {
                                SegmentedControlCapsuleView(viewModel: viewModel, style: style)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                    .padding(.horizontal, 3)
                                    .shadow(color: .black.opacity(0.17), radius: 1)
                            }
                        }
                        .contentShape(.rect)
                }
            }
        }
        .foregroundStyle(.primary)
        .padding(.vertical, 3)
        .background {
            Capsule()
                .fill(style.backgroundColor())
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct SegmentedControlCapsuleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var viewModel: DashboardViewModel
    
    let style: SegmentedControlStyleProvider
    
    var body: some View {
        // Capsule shade behind the text to make colors less bright
        Capsule()
            .fill(style.shadeColor())
            .background(
                // Visible Capsule Color Gradient
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: style.gradientColors(),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            )
    }
}
