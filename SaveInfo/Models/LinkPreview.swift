//
//  LinkPreview.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 07/05/25.
//
import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

struct LinkPreview: UIViewRepresentable {
    
    var metadata: LPLinkMetadata
    var fixedWidth: CGFloat? = nil
    var fixedHeight: CGFloat? = nil
    
    func makeUIView(context: Context) -> LPLinkView {
        let preview = LPLinkView(metadata: metadata)
        preview.translatesAutoresizingMaskIntoConstraints = false
        return preview
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {
        uiView.metadata = metadata
        
        if let width = fixedWidth {
            uiView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = fixedHeight {
            uiView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
}

enum LinkPreviewMode {
    case dashboard
    case category
}
