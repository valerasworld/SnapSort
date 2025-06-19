//
//  ImageAreaAddOrEditItemView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI
import PhotosUI

struct ImageAreaAddOrEditItemView: View {
    
    let infoObject: InfoObject?
    let selectedCategory: Category?
    
    @Binding var uiImage: UIImage?
    
    @State var isPhotoPickerPresented: Bool = false
    @State var selectedPhotoItem: PhotosPickerItem?
    @Binding var hasImageFromLibrary: Bool
    
    var body: some View {
        let width = UIScreen.main.bounds.width
        
        ZStack {
            if let uiimage = uiImage {
                ExistingImageView(uiimage: uiimage, isPhotoPickerPresented: $isPhotoPickerPresented, selectedCategory: selectedCategory, width: width)
            } else {
                AddImageView(isPhotoPickerPresented: $isPhotoPickerPresented, selectedCategory: selectedCategory)
            }
        }
        .overlay(alignment: .bottom) {
            Divider()
        }
        .frame(width: width, height: width)
        .ignoresSafeArea()
        
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
                .photosPickerStyle(.inline)
                .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
            
            
        }
        .onChange(of: selectedPhotoItem) {
            Task {
                await loadImage()
                hasImageFromLibrary = true
                
            }
        }
    }
    
    func loadImage() async {
        guard let selectedPhotoItem,
              let data = try? await selectedPhotoItem.loadTransferable(type: Data.self),
              let loadedImage = UIImage(data: data) else {
            return
        }
        
        // Update the @State so the UI refreshes
        await MainActor.run {
            uiImage = loadedImage
            infoObject?.image = loadedImage
            infoObject?.hasImageFromLibrary = true
        }
    }
}

