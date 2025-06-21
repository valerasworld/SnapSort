//
//  SaveInfoApp.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 30/04/25.
//

import SwiftUI
import SwiftData

@main
struct SaveInfoApp: App {
//    let sharedModelConfiguration = ModelConfiguration("Model",
//        url: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.vzazulin.SnapSort")!
//    )
//    let container = try! ModelContainer(for: InfoObject.self, UserSettings.self, configurations: sharedModelConfiguration)
    
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(SharedModel.container)
            let userDataManager = UserDataManager.load(from: context)
            
            DashboardView()
                .environment(userDataManager)
                .modelContainer(SharedModel.container)
        }
    }
}
/*
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>NSExtension</key>
     <dict>
         <key>NSExtensionAttributes</key>
         <dict>
             <key>NSExtensionActivationRule</key>
             <dict>
               <key>NSExtensionActivationSupportsWebURLWithMaxCount</key>
               <integer>1</integer>
               <key>NSExtensionActivationSupportsImageWithMaxCount</key>
               <integer>1</integer>
             </dict>
         </dict>
         <key>NSExtensionMainStoryboard</key>
         <string>MainInterface</string>
         <key>NSExtensionPointIdentifier</key>
         <string>com.apple.share-services</string>
     </dict>
 </dict>
 </plist>

 */



/*
 //
 //  ShareViewController.swift
 //  ShareExtension
 //
 //  Created by Valery Zazulin on 20/06/25.
 //

 import UIKit
 import Social
 import SwiftUI
 import UniformTypeIdentifiers
 import SwiftData

 class ShareViewController: UIViewController {
     override func viewDidLoad() {
         view.backgroundColor = .red
         // Interactive Dismiss Disabled
         isModalInPresentation = true
         
         if let itemProviders = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments {
             let viewModel = ShareViewModel(itemProviders: itemProviders, extensionContext: extensionContext)
             let hostingView = UIHostingController(rootView: ShareView(viewModel: viewModel))
             addChild(hostingView)
             hostingView.view.frame = view.bounds
             view.addSubview(hostingView.view)
             hostingView.didMove(toParent: self)
         }
     }
 }

 @Observable
 final class ShareViewModel {
     private let itemProviders: [NSItemProvider]
     private let extensionContext: NSExtensionContext?
     
     var shareSheetData: ShareSheetData?
     var modelContainer: ModelContainer?
     var userData: UserDataManager? = nil
     var uniqueCategories: [Category] = []
     var isLoading = true
     
     private let linkPreviewLoader = LinkPreviewLoader()
     
     init(itemProviders: [NSItemProvider], extensionContext: NSExtensionContext?) {
         self.itemProviders = itemProviders
         self.extensionContext = extensionContext
     }

     @MainActor
     func loadUserData() {
         let container = SharedModel.container
         let context = container.mainContext
         self.modelContainer = container
         self.userData = UserDataManager.load(from: context)
     }

     @MainActor
     func loadCategories() async throws {
         let context = SharedModel.container.mainContext
         let all = try context.fetch(FetchDescriptor<InfoObject>())
         self.uniqueCategories = CategoryManager.findUniqueCategories(from: all)
     }

     func extractItem() {
         guard let provider = itemProviders.first else {
             isLoading = false
             return
         }
         
         if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
             provider.loadItem(forTypeIdentifier: UTType.url.identifier) { item, error in
                 if let url = item as? URL {
                     Task {
                         await self.loadPreviewData(fromURL: url)
                     }
                 } else {
                     self.tryLoadImage(from: provider)
                 }
             }
         } else {
             tryLoadImage(from: provider)
         }
     }

     func tryLoadImage(from provider: NSItemProvider) {
         if provider.canLoadObject(ofClass: UIImage.self) {
             _ = provider.loadObject(ofClass: UIImage.self) { object, error in
                 if let image = object as? UIImage {
                     Task { @MainActor in
                         self.shareSheetData = ShareSheetData(
                             title: nil,
                             imageData: image.jpegData(compressionQuality: 0.9),
                             urlString: nil
                         )
                         self.isLoading = false
                     }
                 } else {
                     self.isLoading = false
                 }
             }
         } else {
             self.isLoading = false
         }
     }
     
     func loadPreviewData(fromURL url: URL) async {
         isLoading = true
         var imageData: Data? = nil
         var title: String? = nil
         
         do {
             let metadata = try await linkPreviewLoader.loadMetadata(for: url)
             title = metadata.title
             
             if let imageProvider = metadata.imageProvider {
                 imageData = try await linkPreviewLoader.loadImageData(from: imageProvider)
             }
             
             self.shareSheetData = ShareSheetData(
                 title: title,
                 imageData: imageData,
                 urlString: url.absoluteString
             )
         } catch {
             print("Failed to load preview: \(error)")
             // fallback: just pass url string without preview
             self.shareSheetData = ShareSheetData(
                 title: nil,
                 imageData: nil,
                 urlString: url.absoluteString
             )
         }
         
         isLoading = false
     }
     
     func dismiss() {
         extensionContext?.completeRequest(returningItems: [])
     }
 }



 fileprivate struct ShareView: View {
     @Bindable var viewModel: ShareViewModel

     var body: some View {
         Group {
             if viewModel.isLoading {
                 ProgressView("Loading...")
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
             }
             else if let shareSheetData = viewModel.shareSheetData,
                     let userData = viewModel.userData,
                     let modelContainer = viewModel.modelContainer {

                 AddOrEditItemView(
                     infoObject: nil,
                     shareSheetData: shareSheetData,
                     onDismissFromShareExtension: viewModel.dismiss
                 )
                 .modelContainer(modelContainer)
                 .environment(userData)
                 .environment(\.uniqueCategories, viewModel.uniqueCategories)

             } else {
                 VStack(spacing: 16) {
                     Text("Unable to load content.")
                     Button("Dismiss", action: viewModel.dismiss)
                 }
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
             }
         }
         .onAppear {
             Task { @MainActor in
                 viewModel.extractItem()
                 try? await viewModel.loadCategories()
                 viewModel.loadUserData()
             }
         }
     }
 }



 */
