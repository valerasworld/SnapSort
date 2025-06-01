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
class InfoObject: Hashable, Identifiable {
    var id = UUID().uuidString
    var title: String?
    var image: UIImage?
    var stringURL: String?
    var tags: [String] = []
    var category: Category
    var dateAdded: Date
    var comment: String?
    
    // Link Preview Data
    var previewLoading: Bool = false
    var linkMetaData: LPLinkMetadata?
    var linkURL: URL?
    
    init(
        id: String = UUID().uuidString,
        title: String? = nil,
        image: UIImage? = nil,
        stringURL: String? = nil,
        tags: [String] = [],
        category: Category,
        dateAdded: Date = .now,
        comment: String? = nil,
        previewLoading: Bool = false,
        linkMetaData: LPLinkMetadata? = nil,
        linkURL: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.stringURL = stringURL
        self.tags = tags
        self.category = category
        self.dateAdded = dateAdded
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
