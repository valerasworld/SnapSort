//
//  ExistingImageView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI

struct ExistingImageView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    let uiimage: UIImage
    @Binding var isPhotoPickerPresented: Bool
    let selectedCategory: Category?
    let width: CGFloat
    
    var body: some View {
        // BG Image
        Image(uiImage: uiimage)
            .resizable()
            .scaledToFill()
            .aspectRatio(1/1, contentMode: .fill)
            .frame(maxWidth: width, maxHeight: width)
            .clipped()
        
        LinearGradient(colors: [(colorScheme == .light ? .white : .black), .clear, . clear], startPoint: .bottom, endPoint: .top)
            
        Color.clear.background(.ultraThinMaterial)
            .overlay(alignment: .bottom) {
                    AddNewImageButtonView(selectedCategory: selectedCategory, isPhotoPickerPresented: $isPhotoPickerPresented)
            }
        
        // Actual Image
        Image(uiImage: uiimage)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: width * 0.8, maxHeight: width * 0.65)
            .shadow(color: .black.opacity(0.27), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ExistingImageView(uiimage: UIImage(systemName: "star")!, isPhotoPickerPresented: .constant(false), selectedCategory: nil, width: 100)
}

