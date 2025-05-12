//
//  Untitled.swift
//  SaveInfo
//
//  Created by Pasquale Piserchia on 08/05/25.
//
import SwiftUI

struct DetailedItemView: View {
    
    var category: Category
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color(category.color)
                    .ignoresSafeArea()
                
                VStack(spacing: 5) {
                    Text("Description:")
                        .bold()
                    
                    Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ultrices ante et arcu aliquam fermentum. Cras porta urna sed luctus condimentum. Quisque in sodales nunc.
Integer volutpat enim urna, eu convallis mi vestibulum eget.
Nam placerat, augue ac laoreet tempor, arcu felis dapibus nibh, id ornare orci ligula vel nisl. Vestibulum nec lorem tristique, egestas enim vel, tristique augue. Aliquam erat volutpat.
""")
                    .padding(.horizontal, 20)
                    
                    
                    
                    Text("Link:")
                        .bold()
                    
                    Text("https://www.linkedin.com")
                    
                    
                }
                Spacer()
                
                //                .toolbar {
                //                    ToolbarItem(placement: .topBarLeading) {
                //                        VStack(spacing: 0) {
                //
                //                            Text("Detail Item")
                //                                .font(.title)
                //                                .bold()
//                              Text("#\(category)")
                //                                .font(.subheadline)
                //                                .foregroundColor(category.color)
                //                        }
                //                }
                //        }
                
                    .navigationTitle("Detailed Item")
            }
            
        }
    }
}

#Preview {
    DetailedItemView(category: Category.restaurants)
}
