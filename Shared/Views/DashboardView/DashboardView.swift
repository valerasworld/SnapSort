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
    
    @State private var selectedType: String = types.first!
    @Namespace private var animation
    
    @State var selectedCategories: [Category] = []
    
    
    
    
    var body: some View {
        
        NavigationStack {
            ResizableHeaderScrollView {
//                HStack(spacing: 12) {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "line.horizontal.3")
//                            .font(.title3)
//                    }
//                    
//                    Spacer(minLength: 0)
//                    
////                    Button {
////                        
////                    } label: {
////                        Image(systemName: "magnifyingglass")
////                            .font(.title3)
////                    }
//                    
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "plus")
//                            .font(.title3)
//                    }
//                        
//                }
//                .overlay {
//                    Text("SnapSort")
//                        .fontWeight(.semibold)
//                }
//                .foregroundStyle(.primary)
//                .padding(.horizontal, 15)
//                .padding(.top, 15)
            
            } stickyHeader: {
                HStack(spacing: 10) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                            .foregroundStyle(selectedType == type ? .white : .black)
                            .cornerRadius(10)
                            .fontWeight(selectedType == type ? .semibold : .semibold) // ??
                            .padding(.horizontal, 20)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .background {
                                if selectedType == type {
                                    SegmentedControlCapsuleView(userData: userData)
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
//                .safeAreaPadding(15)
                .padding(.vertical, 3)
                .background {
                    Capsule()
//                        .fill(.black.gradient.opacity(0.07))
                        .fill(.white)
                    //                        .safeAreaPadding(10)
                }
                .padding(.top, -10)
                .padding(.horizontal, 16)
            } categorySelection: {
                HStack {
                    ForEach(userData.findUniqueCategories(), id: \.self) { category in
                        CategoryButtonView(category: category)
                    }
                }
                .padding(.bottom, 12)
                .padding(.horizontal, 16)
            } background: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
            } content: {
                LazyVStack(alignment: .leading) {
//                    Group {
//                        RecentlyAddedSectionHeaderView(userData: userData)
//                        RecentlyAddedSectionScrollView(userData: userData)
//                    }
//                    
//                    
//                    // SEGMENTED CONTROL ?????????!!!!!!!!!!!!
//                    // ADDING NEW ELEMENT BUTTON !!!!!
//                    Group {
//                        CategoriesSectionHeaderView()
//                        CategoriesSectionCardsView(userData: userData)
//                    }
                    InfoObjectListViewMainScreenView(userData: userData)
                       
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SnapSort")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
            
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showModal = true
                    })
                        {
                            Image(systemName: "plus")
                                .foregroundStyle(Color("black"))
                        }
                    
                }
            }
            .sheet(isPresented: $showModal) {
                AddItemView(infoObject: infoObject, category: Category.allCases, titleNewItem: "", descriptionNewItem: "", showModal: $showModal)
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
    
    var body: some View {
        Capsule()
            .fill(.ultraThinMaterial)
            
            .background(
                
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: userData.findUniqueCategories().map{ $0.color },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            )
    }
}
