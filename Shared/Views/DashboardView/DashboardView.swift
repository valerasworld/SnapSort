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
    
    @State private var selectedType: String = types.first!
    @Namespace private var animation
    
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
                            .foregroundStyle(selectedType == type ? .white : .gray)
                            .cornerRadius(10)
                            .fontWeight(selectedType == type ? .semibold : .regular) // ??
                            .padding(.horizontal, 20)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .background {
                                if selectedType == type {
                                    Capsule()
                                        .fill(.blue.gradient)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
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
                .background {
                    Capsule()
                        .fill(.black.gradient.opacity(0.07))
//                        .safeAreaPadding(10)
                }
                .padding(.top, -10)
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
                    Group {
                        RecentlyAddedSectionHeaderView(userData: userData)
                        RecentlyAddedSectionScrollView(userData: userData)
                    }
                    
                    
                    // SEGMENTED CONTROL ?????????!!!!!!!!!!!!
                    // ADDING NEW ELEMENT BUTTON !!!!!
                    Group {
                        CategoriesSectionHeaderView()
                        CategoriesSectionCardsView(userData: userData)
                    }
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
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("black"))
                    }
                }
                
            }
        }
        .environment(userData)
        
    }
}

#Preview {
    DashboardView()
}


