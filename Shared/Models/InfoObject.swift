//
//  InfoObject.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//
import SwiftUI
import LinkPresentation
import SwiftData

@Model
class InfoObject: Identifiable {
    var id = UUID().uuidString
    var title: String? = ""
    
    @Attribute(.externalStorage)
    var imageData: Data?
    
    var image: UIImage? {
            get { imageData.flatMap { UIImage(data: $0) } }
            set { imageData = newValue?.jpegData(compressionQuality: 0.9) }
        }
    
    var stringURL: String? = ""
    
    var tags: [String] = []
    var category: Category
    var dateAdded: Date
    var comment: String? = ""
    
    var isFavorite: Bool = false
    
    var hasImageFromLibrary: Bool = false
    var hasUsersTitle: Bool = false
    var hasValidLink: Bool {
        guard let stringURL = stringURL else { return false }
        return stringURL.isValidURL()
    }
    var hasMetadata: Bool = false
    
    // Link Preview Data
    var previewLoading: Bool = false
    
    @Transient
    var linkMetaData: LPLinkMetadata?
    
    @Transient
    var linkURL: URL?
    
    init(id: String = UUID().uuidString, title: String? = "", imageData: Data? = nil, stringURL: String? = "", tags: [String] = [], category: Category, dateAdded: Date = .now, comment: String? = "", previewLoading: Bool = false, linkMetaData: LPLinkMetadata? = nil, linkURL: URL? = nil, isFavorite: Bool = false, hasImageFromLibrary: Bool = false, hasUsersTitle: Bool = false) {

        self.id = id
        self.title = title
        self.imageData = imageData
        self.stringURL = stringURL
        self.tags = tags
        self.category = category
        self.dateAdded = dateAdded
        self.comment = comment
        self.previewLoading = previewLoading
        self.linkMetaData = linkMetaData
        self.linkURL = linkURL
        self.isFavorite = isFavorite
        self.hasImageFromLibrary = hasImageFromLibrary
        self.hasUsersTitle = hasUsersTitle
    }
}

extension InfoObject: Hashable {
    static func == (lhs: InfoObject, rhs: InfoObject) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct InfoObjectGroup: Identifiable {
    var id: String { formattedDate }
    let formattedDate: String
    let infoObjects: [InfoObject]
}

//extension Array where Element == InfoObject {
//    func findUniqueCategories() -> [Category] {
//        let categories = self.map(\.category)
//        let uniqueCategories = Set(categories)
//        return Array<Category>(uniqueCategories).sorted { $0.name < $1.name }
//    }
//}

//extension Array where Element == InfoObject {
//    func findInfoTypes() -> [InfoType] {
//        let hasLink = contains { $0.hasValidLink }
//        let hasImage = contains { $0.hasImageFromLibrary }
//        
//        switch (hasLink, hasImage) {
//        case (true, true): return [.all, .links, .images]
//        case (true, false): return [.all, .links]
//        case (false, true): return [.all, .images]
//        case (false, false): return [.all]
//        }
//    }
//}
