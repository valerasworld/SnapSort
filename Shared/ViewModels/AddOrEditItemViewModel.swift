//
//  AddOrEditItemViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/06/25.
//

import SwiftUI
import SwiftData

@Observable
class AddOrEditItemViewModel {
    
    var uiImage: UIImage? = nil
    var title: String = ""
    var selectedCategory: Category? = nil
    var stringURL: String = ""
    var comment: String = ""
    
    var isCreateCategorySheetPresented: Bool = false
    
    var hasImageFromLibrary: Bool = false
    var hasUsersTitle: Bool = false
    
    
    func updateViewModelData(from infoObject: InfoObject?, shareSheetData: ShareSheetData?) {
        if let infoObject {
            updateFromInfoObject(infoObject)
        } else if let data = shareSheetData {
            populateFromShareSheet(data)
        }
    }
    
    private func updateFromInfoObject(_ infoObject: InfoObject) {
        title = infoObject.title ?? ""
        selectedCategory = infoObject.category
        stringURL = infoObject.stringURL ?? ""
        comment = infoObject.comment ?? ""
        uiImage = infoObject.image
        hasImageFromLibrary = infoObject.hasImageFromLibrary
        hasUsersTitle = infoObject.hasUsersTitle
    }
    
    private func populateFromShareSheet(_ data: ShareSheetData) {
        print("populateFromShareSheet called, imageData is nil? \(data.imageData == nil)")
        if let title = data.title {
            self.title = title
        }
        if let imageData = data.imageData {
            self.uiImage = UIImage(data: imageData)
            self.hasImageFromLibrary = data.hasChosenImage
        }
        
        if let urlString = data.urlString {
            self.stringURL = urlString
        }
        
    }
    
    func save(_ infoObject: InfoObject?, to modelContext: ModelContext) {
        if let infoObject {
            // Edit the infoObject
            infoObject.title = title
            infoObject.category = selectedCategory ?? .noCategory
            infoObject.stringURL = stringURL.sanitizedURLString
            infoObject.comment = comment
            infoObject.hasImageFromLibrary = hasImageFromLibrary
            infoObject.hasUsersTitle = hasUsersTitle
            
            if let uiImage = uiImage {
                infoObject.image = uiImage
            }
        } else {
            // Add an infoObject
            let newInfoObject = InfoObject(
                title: title,
                stringURL: stringURL.sanitizedURLString,
                tags: [], // CHANGE CHANGE IN THE FUTURE
                category: selectedCategory ?? .noCategory,
                dateAdded: .now,
                comment: comment,
                hasImageFromLibrary: hasImageFromLibrary,
                hasUsersTitle: title != "" ? true : false
            )
            
            if let uiImage = uiImage {
                newInfoObject.image = uiImage
            }
            
            modelContext.insert(newInfoObject)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    
}
