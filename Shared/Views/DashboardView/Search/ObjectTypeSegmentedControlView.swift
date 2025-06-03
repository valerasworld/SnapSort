//
//  ObjectTypeSegmentedControlView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI



struct ObjectTypeSegmentedControlView: View {
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    @Binding var selectedType: InfoType
    @Namespace private var animation
    
    var infoTypes: [InfoType] {
        return infoObjects.findInfoTypes()
    }
        
    var body: some View {
        if infoTypes.isEmpty {
            EmptyView()
        } else {
            HStack(spacing: 10) {
                ForEach(infoTypes, id: \.self) { type in
                    Text(type.typeName)
                        .foregroundStyle((selectedType == type) ? .white : .black)
                        .cornerRadius(10)
                        .fontWeight(.semibold) // ??
                        .padding(.horizontal, 20)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .background {
                            if selectedType == type {
                                SegmentedControlCapsuleView(infoObjects: infoObjects, selectedCategories: $selectedCategories)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                    .padding(.horizontal, 3)
                                    .shadow(color: .black.opacity(0.17), radius: 1)
                            }
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(.snappy/*(duration: 0.3)*/) {
                                selectedType = type
                            }
                        }
                }
            }
            .foregroundStyle(.primary)
            .padding(.vertical, 3)
            .background {
                Capsule()
                    .fill(.white)
            }
            .padding(.top, -10)
            .padding(.horizontal, 16)
        }
    }
}

struct SegmentedControlCapsuleView: View {
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    
    var selectedCategoriesColors: [Color] {
        if selectedCategories.isEmpty {
            return infoObjects.findUniqueCategories().map { $0.color }
        } else {
            return selectedCategories.sorted(by: { $0.name < $1.name} ).map { $0.color }
        }
    }
    
    var body: some View {
        Capsule()
            .fill(.ultraThinMaterial)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: selectedCategoriesColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            )
    }
}
