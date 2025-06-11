//
//  InfoObject.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//
import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers
import SwiftData

@Model
class InfoObject: Hashable, Identifiable {
    var id = UUID().uuidString
    var title: String? = ""
    
//    @Transient
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
    
    // Link Preview Data
    var previewLoading: Bool = false
    
    @Transient
    var linkMetaData: LPLinkMetadata?
    
    @Transient
    var linkURL: URL?
    
    init(
        id: String = UUID().uuidString,
        title: String? = "",
        imageData: Data? = nil,
        stringURL: String? = "",
        tags: [String] = [],
        category: Category,
        dateAdded: Date = .now,
        comment: String? = "",
        previewLoading: Bool = false,
        linkMetaData: LPLinkMetadata? = nil,
        linkURL: URL? = nil,
        isFavorite: Bool = false,
        hasImageFromLibrary: Bool = false,
        hasUsersTitle: Bool = false
    ) {
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

///extension Array where Element == InfoObject {
///    func groupByDate() -> [InfoObjectGroup] {
///        let formatter = DateFormatter()
///        formatter.dateStyle = .medium
///
///        let groupedDict = Dictionary(grouping: self) { infoObject -> String in
///            formatter.string(from: infoObject.dateAdded)
///        }
///
///        let result = groupedDict.map { (formattedDate, objects) in
///            InfoObjectGroup(formattedDate: formattedDate, infoObjects: objects)
///        }
///
///        return result.sorted { $0.formattedDate > $1.formattedDate }
///    }
///}

//extension Array where Element == InfoObject {
//    func groupByDate() -> [(date: Date, infoObjects: [InfoObject])] {
//        let groupedDictionary = Dictionary(grouping: self) { $0.dateAdded.startOfDay() }
//        return groupedDictionary
//            .map { ($0.key, $0.value) }
//            .sorted { $0.0 > $1.0 }
//    }
//}

//extension Array where Element == InfoObject {
//    func findUniqueCategories() -> [Category] {
//        let categories = self.map { $0.category }
//        let uniqueCategories = Dictionary(grouping: categories, by: { $0.id }).compactMap { $0.value.first }
//        return Set(uniqueCategories).sorted { $0.name < $1.name }
//    }
//}

extension Array where Element == InfoObject {
    func findUniqueCategories() -> [Category] {
        let categories = self.map(\.category)
        let uniqueCategories = Set(categories)
        return Array<Category>(uniqueCategories).sorted { $0.name < $1.name }
    }
}

extension Array where Element == InfoObject {
    func findInfoTypes() -> [InfoType] {
        let hasLink = contains { $0.linkURL != nil }
        let hasImage = contains { $0.image != nil }
        
        switch (hasLink, hasImage) {
        case (true, true): return [.all, .links, .images]
        case (true, false): return [.all, .links]
        case (false, true): return [.all, .images]
        default: return []
        }
    }
}
