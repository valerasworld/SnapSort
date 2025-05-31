//
//  InfoObject.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//
import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

@Observable
class InfoObject: Hashable, Identifiable, ObservableObject {
    var id = UUID().uuidString
    var title: String?
    var description: String?
    var author: String?
    var image: UIImage?
    var genre: String?
    var stringURL: String?
    var tags: [String] = []
    var category: Category
    var dateAdded: Date
    var completed: Bool?
    var comment: String?
    
    // Link Preview Data...
    
    // Preview Loading...
    var previewLoading: Bool = false
    // Meta Data...
    var linkMetaData: LPLinkMetadata?
    // URL...
    var linkURL: URL?
    
    init(
        id: String = UUID().uuidString,
        title: String? = nil,
        description: String? = nil,
        author: String? = nil,
        image: UIImage? = nil,
        genre: String? = nil,
        stringURL: String? = nil,
        tags: [String] = [],
        category: Category,
        dateAdded: Date,
        completed: Bool? = nil,
        comment: String? = nil,
        previewLoading: Bool = false,
        linkMetaData: LPLinkMetadata? = nil,
        linkURL: URL? = nil
    ) {
        self.id = id
        self.title = title
//        self.description = description
//        self.author = author
        self.image = image
//        self.genre = genre
        self.stringURL = stringURL
        self.tags = tags
        self.category = category
        self.dateAdded = dateAdded
//        self.completed = completed
        self.comment = comment
        self.previewLoading = previewLoading
        self.linkMetaData = linkMetaData
        self.linkURL = linkURL
    }
    
    static func == (lhs: InfoObject, rhs: InfoObject) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
