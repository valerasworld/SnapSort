//
//  ShareViewController.swift
//  Share
//
//  Created by Valery Zazulin on 14/05/25.
//

import UIKit
import SwiftUI
import Social
import LinkPresentation
import UniformTypeIdentifiers


class ShareViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
        // Interactive Dismiss Disabled
        isModalInPresentation = true
        
        if let itemProviders = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments {
            let hostingView = UIHostingController(rootView: ShareView(itemProviders: itemProviders , extensionContext: extensionContext, colorTheme: .pastel))
            addChild(hostingView)
            hostingView.view.frame = view.bounds
            view.addSubview(hostingView.view)
            hostingView.didMove(toParent: self)
        }
        
        
    }
}

fileprivate struct ShareView: View {
    
    var itemProviders: [NSItemProvider] = []
    var extensionContext: NSExtensionContext?
    
    var colorTheme: ColorTheme
    
    // View Properties
    @State private var infoObject: InfoObject?
    @State private var isLoading = true
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            Group {
                if let infoObject {
//                    DetailedItemView(infoObject: infoObject, viewModel: DashboardViewModel())
//                        .toolbar {
//                            ToolbarItem(placement: .cancellationAction) {
//                                Button("Cancel", action: dismiss)
//                            }
//                        }
                } else if isLoading {
                    ProgressView("Loading link...")
                } else {
                    Text("No valid URL found.")
                    Button("Cancel", action: dismiss)
                }
            }
            .overlay {
                VStack {
                    ZStack {
                        Text(" ")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading) {
                                HStack {
                                    Button ("Cancel") {
                                        dismiss()
                                    }
                                    .tint(.red)
                                    Spacer()
                                    Button ("Save") {
                                        dismiss()
                                    }
                                }
                            }
                        
                        Spacer (minLength: 0)
                    }
                    Spacer()
                    
                }
                .padding([.horizontal, .top])
            }
            .onAppear {
                extractURL()
            }
            
        }
    }
    
    // Extracting Link Data
    func extractURL() {
        for provider in itemProviders {
            if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.url.identifier) { item, error in
                    if let data = item as? URL {
                        Task {
                            await createInfoObject(from: data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                    }
                }
                break
            }
        }
    }
    
    func createInfoObject(from url: URL) async {
        let infoObject = InfoObject(
            stringURL: url.absoluteString,
            category: Category(name: "No Category", colorName: "gray", iconName: "questionmark"),
            dateAdded: Date()
        )
        let viewModel = InfoObjectCardViewModel(infoObject: infoObject)
        do {
            try await viewModel.loadPreview()
            DispatchQueue.main.async {
                self.infoObject = infoObject
                self.isLoading = false
            }
        } catch {
            print("Failed to load preview: \(error)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func dismiss() {
        extensionContext?.completeRequest(returningItems: [])
    }
    
    private struct ImageItem: Identifiable {
        let id: UUID = .init()
        var imageData: Data
        var previewImage: UIImage?
    }
}
