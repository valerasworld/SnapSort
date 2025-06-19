//
//  InfoObjectCardViewModel.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 09/05/25.
//

import SwiftUI
import LinkPresentation

@Observable
class InfoObjectCardViewModel {
    
    var infoObject: InfoObject
    private let previewService: PreviewLoadingService
    
    // View Properties
    var previewLoading: Bool = false
    var cornerRadius: CGFloat = 10
    
    init(
        infoObject: InfoObject,
        previewService: PreviewLoadingService = LinkPreviewService(
            metadataLoader: LinkPreviewLoader(),
            imageLoader: LinkPreviewLoader()
        )
    ) {
        self.infoObject = infoObject
        self.previewService = previewService
    }
    
    func loadPreview() async throws {
        previewLoading = true
        do {
            try await previewService.loadPreview(for: infoObject)
        } catch {
            print("Preview loading failed: \(error)")
        }
        previewLoading = false
    }
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
              stringURL.isValidURL(),
              let url = URL(string: stringURL) else {
            return
        }
        
        infoObject.linkURL = url
        
        do {
            let metadata = try await metadataLoader.loadMetadata(for: url)
            setFetchedMetadata(metadata, for: infoObject)
            infoObject.hasMetadata = true
        } catch {
            print("Metadata error: \(error)")
        }
        
        if !infoObject.hasImageFromLibrary {
            if let imageProvider = infoObject.linkMetaData?.imageProvider {
                do {
                    if let data = try await imageLoader.loadImageData(from: imageProvider),
                       let uiImage = UIImage(data: data) {
                        await MainActor.run {
                            infoObject.image = uiImage
                        }
                    }
                } catch {
                    print("Image load error: \(error)")
                }
            }
        }
    }
    
    private func setFetchedMetadata(_ metadata: LPLinkMetadata, for infoObject: InfoObject) {
        infoObject.linkMetaData = metadata
        infoObject.title = infoObject.hasUsersTitle ? infoObject.title : metadata.title
    }
}
