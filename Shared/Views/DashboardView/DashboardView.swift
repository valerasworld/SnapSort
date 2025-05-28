//
//  DashboardView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI

let types: [String] = ["All", "Links", "Images"]

struct DashboardView: View {
    
    @State var userData = UserData()
    @State var searchText: String = ""
    @State var showModal: Bool = false
    let infoObject: InfoObject
    @State var selectedType: String = types.first!
    
    @State var selectedCategories: [Category] = []
    
    var uniqueCategories: [Category] {
        return userData.findUniqueCategories()
    }
    
    var body: some View {
        
        NavigationStack {
            ResizableHeaderScrollView {
                
            } stickyHeader: {
                ObjectTypeSegmentedControlView(
                    selectedType: $selectedType,
                    userData: userData,
                    uniqueCategories: uniqueCategories
                )
            } categoryFilter: {
                CtegoriesFilterView(uniqueCategories: uniqueCategories)
            } background: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
            } content: {
                    InfoObjectListViewMainScreenView(userData: userData)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SnapSort")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showModal = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("black"))
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                AddItemView(infoObject: infoObject, category: Category.allCases, titleNewItem: "", descriptionNewItem: "", showModal: $showModal, userData: $userData)
            }
            
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView(infoObject: .init(category: Category.books, dateAdded: Date()))
}



struct CategoryButtonView: View {
    var category: Category
    @State var isCategorySelected: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isCategorySelected ? .clear : .white)
                .padding(isCategorySelected ? 0 : 2)
                .background(coloredCircled)
            if isCategorySelected {
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .bold()
            } else {
                Circle()
                    .foregroundStyle(.clear)
                    .background(coloredCircled)
                    .mask {
                        Image(systemName: category.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
        //                    .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .bold()
                    }
            }
        }
        .frame(width: 36)
//        .frame(width: 50)
        .onTapGesture {
            withAnimation(.spring(duration: 0.25)) {
                isCategorySelected.toggle()
            }
        }
    }
    
    var coloredCircled: some View {
        ZStack {
            Circle()
                .fill(category.color)
            
            Circle()
                .fill(.ultraThinMaterial)
        }
    }
}

struct SegmentedControlCapsuleView: View {
    var userData: UserData
    var uniqueCategories: [Category]
    
    var body: some View {
        Capsule()
            .fill(.ultraThinMaterial)
            
            .background(
                
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: uniqueCategories.map{ $0.color },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            )
    }
}

struct ObjectTypeSegmentedControlView: View {
    
    @Binding var selectedType: String
    var userData: UserData
    @Namespace private var animation
    var uniqueCategories: [Category]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(types, id: \.self) { type in
                Text(type)
                    .foregroundStyle((selectedType == type) ? .white : .black)
                    .cornerRadius(10)
                    .fontWeight(.semibold) // ??
                    .padding(.horizontal, 20)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .background {
                        if selectedType == type {
                            SegmentedControlCapsuleView(userData: userData, uniqueCategories: uniqueCategories)
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

struct CtegoriesFilterView: View {
    var uniqueCategories: [Category]
    
    var body: some View {
        HStack {
            ForEach(uniqueCategories, id: \.self) { category in
                CategoryButtonView(category: category)
            }
        }
        .padding(.bottom, 12)
        .padding(.horizontal, 16)
    }
}
