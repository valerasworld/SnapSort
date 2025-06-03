//
//  InfoObjectCardViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 09/05/25.
//

import SwiftUI

@Observable
class InfoObjectCardViewModel {
    
    var infoObject: InfoObject
    
//    private let metadataLoader: MetadataLoadable
//    private let imageLoader: ImageLoadable
    private let previewService: PreviewLoadingService
    
    // View Properties
    var previewLoading: Bool = false
    var cornerRadius: CGFloat = 10
    
    init(
        infoObject: InfoObject,
//        metadataLoader: MetadataLoadable = LinkPreviewLoader(),
//        imageLoader: ImageLoadable = LinkPreviewLoader()
        previewService: PreviewLoadingService = LinkPreviewService(
                    metadataLoader: LinkPreviewLoader(),
                    imageLoader: LinkPreviewLoader()
                )
    ) {
        self.infoObject = infoObject
//        self.metadataLoader = metadataLoader
//        self.imageLoader = imageLoader
        self.previewService = previewService
    }
        
    // Load preview data (Metadata and Image)
//    func loadPreview() async throws {
//        
//        guard let url = validatedURL() else { return }
//        
//        previewLoading = true
//        infoObject.linkURL = url
//        
//        await loadMetadata(for: url)
//        await loadImageIfAvailable()
//
//        previewLoading = false
//    }
    
    func loadPreview() async {
            previewLoading = true
            do {
                try await previewService.loadPreview(for: infoObject)
            } catch {
                print("Preview loading failed: \(error)")
            }
            previewLoading = false
        }
    
    // MARK: - Private Helper Methods
    
//    private func validatedURL() -> URL? {
//        guard let stringURL = infoObject.stringURL,
//              let url = URL(string: stringURL),
//              url.scheme == "http" || url.scheme == "https" else {
//            return nil
//        }
//        return url
//    }
//    
//    private func loadMetadata(for url: URL) async {
//        do {
//            let metadata = try await metadataLoader.loadMetadata(for: url)
//            infoObject.linkMetaData = metadata
//            infoObject.title = metadata.title ?? infoObject.title
//        } catch {
//            print("Error loading Metadata: \(error)")
//        }
//    }
//    
//    private func loadImageIfAvailable() async {
//        guard let imageProvider = infoObject.linkMetaData?.imageProvider else { return }
//        do {
//            infoObject.image = try await imageLoader.loadImage(from: imageProvider)
//        } catch {
//            print("Error loading Image: \(error)")
//        }
//    }
    
}

protocol PreviewLoadingService {
    func loadPreview(for infoObject: InfoObject) async throws
}

final class LinkPreviewService: PreviewLoadingService {
    private let metadataLoader: MetadataLoadable
    private let imageLoader: ImageLoadable
    
    init(metadataLoader: MetadataLoadable, imageLoader: ImageLoadable) {
        self.metadataLoader = metadataLoader
        self.imageLoader = imageLoader
    }
    
    func loadPreview(for infoObject: InfoObject) async throws {
        guard let stringURL = infoObject.stringURL,
              let url = URL(string: stringURL),
              url.scheme == "http" || url.scheme == "https" else {
            return
        }
        
        infoObject.linkURL = url
        
        do {
            let metadata = try await metadataLoader.loadMetadata(for: url)
            infoObject.linkMetaData = metadata
            infoObject.title = metadata.title ?? infoObject.title
        } catch {
            print("Metadata error: \(error)")
        }
        
//        if let imageProvider = infoObject.linkMetaData?.imageProvider {
//            do {
//                infoObject.image = try await imageLoader.loadImage(from: imageProvider)
//            } catch {
//                print("Image load error: \(error)")
//            }
//        }
        if let imageProvider = infoObject.linkMetaData?.imageProvider {
            do {
                if let data = try await imageLoader.loadImageData(from: imageProvider),
                   let uiImage = UIImage(data: data) {
                    infoObject.image = uiImage
                }
            } catch {
                print("Image load error: \(error)")
            }
        }
    }
}
