//
//  AddOrEditView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 03/06/25.
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI

struct AddOrEditView: View {
    @Bindable var infoObject: InfoObject
    
    @State var isPhotoPickerPresented: Bool = false
    @State var selectedPhotoItem: PhotosPickerItem?
    
    var body: some View {
        Section("Image") {
            VStack {
                if let uiimage = infoObject.image {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            isPhotoPickerPresented.toggle()
                        }
                } else {
                    ContentUnavailableView(
                        "No picture",
                        systemImage: "photo.fill",
                        description: Text("No image selected"))
                    .onTapGesture {
                        isPhotoPickerPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isPhotoPickerPresented) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
                    .photosPickerStyle(.inline)
                    .photosPickerDisabledCapabilities([.collectionNavigation, .search])
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.clear)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
                
                
            }
            .onChange(of: selectedPhotoItem) {
                Task {
                    guard let selectedPhotoItem,
                          let data = try? await selectedPhotoItem.loadTransferable(type: Data.self),
                          let uiImage = UIImage(data: data) else {
                        return
                    }
                    infoObject.image = uiImage
                }
            }
        }
    }
}

#Preview {
    AddOrEditView(infoObject: InfoObject(category: Category(name: "No Category", colorName: "gray", iconName: "questionMark")))
}
