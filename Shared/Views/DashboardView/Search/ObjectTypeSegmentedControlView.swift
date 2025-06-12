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
    
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    @Binding var selectedType: InfoType
    @Namespace private var animation
    
    @Binding var availableTypes: [InfoType]
    
    var hasTypes: Bool { availableTypes != [.all] }
        
    var body: some View {
//        if availableTypes.isEmpty || availableTypes == [.all] {
//            Color.clear
//                .background {
//                    Capsule()
//                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)))
//                }
//                .frame(height: 30)
//                .padding(.vertical, 3)
//                .background {
//                    Capsule()
//                        .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)))
//                }
////                .padding(.top, -10)
//                .padding(.horizontal, 16)
//        } else {
            HStack(spacing: 10) {
                ForEach(availableTypes, id: \.self) { type in
                    Text(type.typeName)
                        .foregroundStyle(findCapsuleTextForegroundColor(isSelectedType: type == selectedType))
//
                        .cornerRadius(10)
                        .fontWeight(.semibold) // ??
                        .padding(.horizontal, 20)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .background {
                            if selectedType == type {
                                SegmentedControlCapsuleView(infoObjects: infoObjects, selectedCategories: $selectedCategories, availableTypes: $availableTypes)
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
//            .padding(.top, -10)
            .padding(.horizontal, 16)
//        }
    }
    
    private func findCapsuleTextForegroundColor(isSelectedType: Bool) -> Color {
        if hasTypes {
            switch colorScheme {
            case .light : return isSelectedType ? .white : Color(#colorLiteral(red: 0.5254898071, green: 0.525490582, blue: 0.5426864624, alpha: 1))
            case .dark : return isSelectedType ? .white : Color(#colorLiteral(red: 0.5254898071, green: 0.525490582, blue: 0.5426864624, alpha: 1))
            default : return .white
            }
            
        } else {
            return colorScheme == .light ? Color(#colorLiteral(red: 0.4941170812, green: 0.4941180944, blue: 0.5156010985, alpha: 1)) : Color(#colorLiteral(red: 0.6117640734, green: 0.6117651463, blue: 0.6375455856, alpha: 1))
        }
    }
}

struct SegmentedControlCapsuleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var infoObjects: [InfoObject]
    @Binding var selectedCategories: [Category]
    
    @Binding var availableTypes: [InfoType]
    
    var selectedCategoriesColors: [Color] {
        if selectedCategories.isEmpty {
            return infoObjects.findUniqueCategories().sortByColor().map { $0.color(for: userData.colorTheme, colorScheme: colorScheme) }
        } else {
            return selectedCategories.sortByColor().map { $0.color(for: userData.colorTheme, colorScheme: colorScheme) }
        }
    }
    
    var body: some View {
        Capsule()
            .fill(colorScheme == .light ?
                  (availableTypes == [.all] ? Color(#colorLiteral(red: 0.8823527694, green: 0.882353127, blue: 0.8909617066, alpha: 1)) : .white.opacity(0.3))
                  : (availableTypes == [.all] ? Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)) : Color(#colorLiteral(red: 0.2039213479, green: 0.2039217353, blue: 0.2125178874, alpha: 1)).opacity(0.3)))
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
