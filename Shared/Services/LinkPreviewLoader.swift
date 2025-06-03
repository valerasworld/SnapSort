//
//  LinkPreviewLoader.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 19/05/25.
//
import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

protocol MetadataLoadable {
    func loadMetadata(for url: URL) async throws -> LPLinkMetadata
}

protocol ImageLoadable {
//    func loadImage(from provider: NSItemProvider?) async throws -> UIImage?
    func loadImageData(from provider: NSItemProvider?) async throws -> Data?
}

class LinkPreviewLoader: MetadataLoadable, ImageLoadable {
    func loadMetadata(for url: URL) async throws -> LPLinkMetadata {
        let provider = LPMetadataProvider()
        return try await provider.startFetchingMetadata(for: url)
    }
    
//    // Convert NSItemProvider to UIImage
//    func loadImage(from provider: NSItemProvider?) async throws -> UIImage? {
//        let typeIdentifier = UTType.image.identifier
//        
//        // Check if the provider contains the image type
//        guard let provider,
//              provider.hasItemConformingToTypeIdentifier(typeIdentifier) else { return nil }
//        
//        // Load the item asynchronously
//        let item = try await loadImageItem(from: provider, for: typeIdentifier)
//
//        return try decodeImage(from: item)
//    }
    
    func loadImageData(from provider: NSItemProvider?) async throws -> Data? {
        let typeIdentifier = UTType.image.identifier
        
        guard let provider,
              provider.hasItemConformingToTypeIdentifier(typeIdentifier) else { return nil }
        
        let item = try await loadImageItem(from: provider, for: typeIdentifier)
        
        return try extractImageData(from: item)
    }
    
    // MARK: - Private Helper Methods
    
    private func loadImageItem(from provider: NSItemProvider, for typeIdentifier: String) async throws -> NSSecureCoding {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.loadItem(forTypeIdentifier: typeIdentifier, options: nil) { item, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let item = item {
                    continuation.resume(returning: item)
                } else {
                    continuation.resume(throwing: NSError(domain: "Invalid item type", code: -1))
                }
            }
        }
    }
    
//    private func decodeImage(from item: NSSecureCoding) throws -> UIImage? {
//        if let image = item as? UIImage {
//            return image
//        } else if let url = item as? URL {
//            let data = try Data(contentsOf: url)
//            return UIImage(data: data)
//        } else if let data = item as? Data {
//            return UIImage(data: data)
//        }
//        return nil
//    }
    private func extractImageData(from item: NSSecureCoding) throws -> Data? {
        if let image = item as? UIImage {
            return image.jpegData(compressionQuality: 0.9) // or pngData()
        } else if let url = item as? URL {
            return try Data(contentsOf: url)
        } else if let data = item as? Data {
            return data
        }
        return nil
    }
}
