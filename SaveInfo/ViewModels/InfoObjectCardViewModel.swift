//
//  InfoObjectCardViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 09/05/25.
//

import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

@Observable
class InfoObjectCardViewModel {
    
    var infoObject: InfoObject
    var previewLoading: Bool = false
    
    init(infoObject: InfoObject) {
        self.infoObject = infoObject
    }
    
    // Check if the URL is valid
    func hasURL() -> Bool {
        guard let stringURL = infoObject.stringURL else {
            return false
        }
        if let url = URL(string: stringURL) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    // Load preview data (Metadata and Image)
    func loadPreview() async throws {
        guard let stringURL = infoObject.stringURL,
              let url = URL(string: stringURL),
              await UIApplication.shared.canOpenURL(url) else {
            return
        }

        previewLoading = true
        infoObject.linkURL = url

        let provider = LPMetadataProvider()
        do {
            let metadata = try await provider.startFetchingMetadata(for: url)
            infoObject.linkMetaData = metadata
            infoObject.title = metadata.title ?? ""
            
            if let imageProvider = metadata.imageProvider {
                infoObject.image = try await convertToImage(imageProvider)
            }
        } catch {
            print("Error loading preview: \(error)")
        }

        previewLoading = false
    }
    
    // Fetch image from metadata URL
    func fetchImageFromMetadata(url: URL) async -> UIImage? {
        let provider = LPMetadataProvider()
        do {
            let metadata = try await provider.startFetchingMetadata(for: url)
            infoObject.linkMetaData = metadata

            if let imageProvider = metadata.imageProvider {
                return try await convertToImage(imageProvider)
            }
        } catch {
            print("Error fetching metadata: \(error)")
        }
        return nil
    }
    
    // Convert NSItemProvider to UIImage
    func convertToImage(_ provider: NSItemProvider?) async throws -> UIImage? {
        guard let provider else { return nil }
        
        let typeIdentifier = UTType.image.identifier
        
        // Check if the provider contains the image type
        guard provider.hasItemConformingToTypeIdentifier(typeIdentifier) else { return nil }
        
        // Load the item asynchronously
        let item: NSSecureCoding = try await withCheckedThrowingContinuation { continuation in
            provider.loadItem(forTypeIdentifier: typeIdentifier, options: nil) { item, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let item = item {
                    continuation.resume(returning: item)
                } else {
                    continuation.resume(throwing: NSError(domain: "Invalid item type", code: -1))
                }
            }
        }
        
        // Handle the possible item types
        if let image = item as? UIImage {
            return image
        } else if let url = item as? URL {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } else if let data = item as? Data {
            return UIImage(data: data)
        }
        
        return nil
    }
}
