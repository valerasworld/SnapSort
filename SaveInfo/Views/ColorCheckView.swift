//
//  ColorCheckView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 06/06/25.
//

import SwiftUI

struct ColorCheckView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.black)
                HStack {
                    
                }
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.black)
            }
            
        }
        .ignoresSafeArea()
        .overlay {
            Image("colors_snapSort")
                .resizable()
                .scaledToFill()
        }
    }
}

#Preview {
    ColorCheckView()
}
