//
//  ObjectTypeSegmentedControlView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//
import SwiftUI



struct ObjectTypeSegmentedControlView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    @Binding var selectedType: InfoType
    @Namespace private var animation
    
    var infoTypes: [InfoType] {
        return infoObjects.findInfoTypes()
    }
        
    var body: some View {
        if infoTypes.isEmpty {
            Color.clear
                .background {
                    Capsule()
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)))
                }
                .frame(height: 30)
                .padding(.vertical, 3)
                .background {
                    Capsule()
                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)))
                }
                .padding(.top, -10)
                .padding(.horizontal, 16)
        } else {
            HStack(spacing: 10) {
                ForEach(infoTypes, id: \.self) { type in
                    Text(type.typeName)
                        .foregroundStyle((selectedType == type) ?
                                         (colorScheme == .light ? .white : .white) :
                                            (colorScheme == .light ? Color(#colorLiteral(red: 0.5019603968, green: 0.5019611716, blue: 0.5191558003, alpha: 1)) : Color(#colorLiteral(red: 0.6352935433, green: 0.6352946758, blue: 0.6610768437, alpha: 1)))
                        )
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
                    .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)))
            }
            .padding(.top, -10)
            .padding(.horizontal, 16)
        }
    }
}

struct SegmentedControlCapsuleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    
    var selectedCategoriesColors: [Color] {
        if selectedCategories.isEmpty {
            return infoObjects.findUniqueCategories().map { $0.color(for: userData.colorTheme, colorScheme: colorScheme) }
        } else {
            return selectedCategories.sorted(by: { $0.name < $1.name} ).map { $0.color(for: userData.colorTheme, colorScheme: colorScheme) }
        }
    }
    
    var body: some View {
        Capsule()
            .fill(colorScheme == .light ? .white.opacity(0.3) : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)).opacity(0.3))
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
