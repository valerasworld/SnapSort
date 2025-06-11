////
////  AddOrEditView.swift
////  SaveInfo
////
////  Created by Valery Zazulin on 03/06/25.
////
//
import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI
//
//struct AddOrEditView: View {
//    @Bindable var infoObject: InfoObject
//    
//    @State var isPhotoPickerPresented: Bool = false
//    @State var selectedPhotoItem: PhotosPickerItem?
//    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) private  var dismiss
//    
//    @State var showCreateCategroySheet: Bool = false
//    
//    @State var isEditing: Bool
//    
//    var infoObjects: [InfoObject]
//        
//    var body: some View {
//        NavigationStack {
//            let width = UIScreen.main.bounds.width
//            ScrollView {
//                ZStack {
//                    if let uiimage = infoObject.image {
//                        Image(uiImage: uiimage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(maxWidth: width, maxHeight: width)
//                            .aspectRatio(1/1, contentMode: .fill)
//                        LinearGradient(colors: [.white, . clear], startPoint: .bottom, endPoint: .top)
//                        
//                        Color.clear
//                            .background(.ultraThinMaterial)
//                    } else {
//                        Color.clear
//                            .background(.ultraThinMaterial)
//                    }
//                    
//                    
//                    VStack {
//                        if let uiimage = infoObject.image {
//                            Image(uiImage: uiimage)
//                                .resizable()
//                                .scaledToFit()
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                                .frame(maxWidth: width * 0.8, maxHeight: width * 0.65)
//                            
//                                .onTapGesture {
//                                    isPhotoPickerPresented.toggle()
//                                }
//                                .shadow(color: .black.opacity(0.17), radius: 10, x: 0, y: 10)
//                        } else {
//                            ZStack {
//                                LinearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom)
//                                Color.clear
//                                    .background(.ultraThinMaterial)
//                                ContentUnavailableView(
//                                    "Image",
//                                    systemImage: "photo.fill",
//                                    description: Text("No image selected"))
//                                .onTapGesture {
//                                    isPhotoPickerPresented.toggle()
//                                }
//                            }
//                            
//                            
//                        }
//                    }
//                }
//                
//                .frame(width: width, height: width)
//                .ignoresSafeArea()
//                
//                .sheet(isPresented: $isPhotoPickerPresented) {
//                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) { }
//                        .photosPickerStyle(.inline)
//                        .photosPickerDisabledCapabilities([.collectionNavigation, .search])
//                        .presentationDetents([.medium, .large])
//                        .presentationBackgroundInteraction(.enabled(upThrough: .large))
//                    
//                    
//                }
//                .onChange(of: selectedPhotoItem) {
//                    Task {
//                        guard let selectedPhotoItem,
//                              let data = try? await selectedPhotoItem.loadTransferable(type: Data.self),
//                              let uiImage = UIImage(data: data) else {
//                            return
//                        }
//                        infoObject.image = uiImage
//                    }
//                }
//                Form {
//                    Section("Title") {
//                        if let title = Binding($infoObject.title) {
//                            TextField("Add Title", text: title, prompt: Text("Add Title"))
//                                .textFieldStyle(.roundedBorder)
//                        }
//                    }
//                    .font(.title3)
//                    .bold()
//                    .padding(.horizontal)
//                    
//                    
//                }
//                .formStyle(.columns)
//                
//                Menu {
//                    ForEach(infoObjects.findUniqueCategories(), id: \.self) { category in
//                        Button(action: {
//                            infoObject.category = category
//                        }) {
//                            Label(category.name.capitalized, systemImage: category.iconName)
//                                .tint(category.color)
//                        }
//                    }
//                    
//                } label: {
//                    HStack {
//                        Image(systemName: infoObject.category.iconName)
//                            .foregroundStyle(infoObject.category.color)
//                        
//                        Text(infoObject.category.name)
//                            .foregroundStyle(infoObject.category.color)
//                        
////                        Image(systemName: "chevron.right")
////                            .foregroundStyle(.gray)
//                    }
//                }
//                Button {
//                    showCreateCategroySheet.toggle()
//                } label: {
//                    HStack {
//                        Image(systemName: "plus.circle")
//                        Text("Add New")
//                        
//                    }
//                }
//                .sheet(isPresented: $showCreateCategroySheet) {
//                    CreateCategorySheetView(infoObject: infoObject,
//                        category: Category(
//                            name: "No Category",
//                            colorName: "gray",
//                            iconName: "questionmark"
//                        )
//                    )
//                }
//                
//            }
//            .ignoresSafeArea()
////            .navigationTitle("Add New")
//            .toolbarTitleDisplayMode(.inline)
////            .toolbarVisibility(.hidden, for: .navigationBar)
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        infoObject.isFavorite.toggle()
//                    } label: {
//                        Image(systemName: infoObject.isFavorite ? "heart.fill" : "heart")
//                    }
//                }
//                ToolbarItem {
//                    Button(isEditing ? "Save" : "Add") {
//                        if isEditing {
//                            dismiss()
//                        } else {
//                            modelContext.insert(infoObject)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    
//    AddOrEditView(
//        infoObject: InfoObject(
//            title: "",
//            category: Category(
//                name: "No Category",
//                colorName: "gray",
//                iconName: "questionMark"
//            ), dateAdded: Date.now
//        ), isEditing: false, infoObjects: []
//    )
//}
//


struct GetHeightModifier: ViewModifier {
    @Binding var height: CGFloat
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    height = geo.size.height
                }
                return Color.clear
            }
        )
    }
}

enum CurrentCreateCategorySheetView {
    case name
    case color
    case icon
}

struct CreateCategorySheetView: View {
    
    @Binding var selectedCategory: Category?
    
    @State private var sheetHeight: CGFloat = .zero
    
    @State private var newCategoryName: String = ""
    @State var selectedColorName: String = "gray"
    @State var selectedIconName: String = "questionmark"
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
            
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack {
                VStack(spacing: 16) {
                    HStack {
                        Text("Add New Category")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.title3)
                        
                        TextField("Name", text: $newCategoryName)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorScheme == .light ? Color(#colorLiteral(red: 0.9019606709, green: 0.9019609094, blue: 0.9062663913, alpha: 1)) : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                            }
                    }
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    HStack {
                        Text("Color")
                            .font(.title3)
                        
                        Spacer(minLength: 0)
                        
                        Circle()
                            .foregroundStyle(Color(Category(name: "", colorName: selectedColorName, iconName: "").color(for: userData.colorTheme, colorScheme: colorScheme)))
                            .frame(width: 45, height: 45)
                    }
                    
                    CustomColorPickerView(selectedColorName: $selectedColorName)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    HStack {
                        Text("Icon")
                            .font(.title3)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: selectedIconName)
                            .font(.title2)
                            .frame(width: 45, height: 45)
                    }
                    
                    IconPickerView(selectedIconName: $selectedIconName, selectedCategoryColorName: $selectedColorName)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    HStack {
                        Text("Preview")
                            .font(.title3)
                        
                        Spacer(minLength: 0)
                            
                        Text(newCategoryName)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color.named(selectedColorName, colorTheme: userData.colorTheme, colorScheme: colorScheme))
                                .padding(0)
                            
                            Image(systemName: selectedIconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(colorScheme == .light ? .white : .black)
                                .fontWeight(.semibold)
                                .bold()
                        }
                        .frame(width: 40)
                        
                        InfoCardBookmarkView(
                            category: Category(
                                name: newCategoryName,
                                colorName: selectedColorName,
                                iconName: selectedIconName
                            )
                        )
                        .offset(y: 3)
                        
                        
                    }
                    .frame(height: 40)
                    
                }
                .padding(.vertical, 6)
            }
            .compositingGroup()
            
            Button {
                selectedCategory = Category(
                    name: newCategoryName,
                    colorName: selectedColorName,
                    iconName: selectedIconName
                )
                dismiss()
            } label: {
                Text("Create New Category")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .foregroundStyle(colorScheme == .light ? .white : .black)
                    .background(colorScheme == .light ? .black : .white, in: .capsule)
            }
            .padding(.top, 15)
        }
        .padding(20)
        .modifier(GetHeightModifier(height: $sheetHeight))
        .presentationDetents([.height(sheetHeight)])
        .background(RemoveSheetBackground())
    }
    
    @ViewBuilder
    func View1() -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Add New Category")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer(minLength: 0)
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                }
            }
            
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.title3)
                
                TextField("Name", text: $newCategoryName)
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .light ? .white : Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)))
                    }
            }
            
            Divider()
                .padding(.vertical, 4)
            
            HStack {
                Text("Color")
                    .font(.title3)
                
                Spacer(minLength: 0)
                
                Circle()
                    .foregroundStyle(Color(Category(name: "", colorName: selectedColorName, iconName: "").color(for: userData.colorTheme, colorScheme: colorScheme)))
                    .frame(width: 45, height: 45)
            }
            
            CustomColorPickerView(selectedColorName: $selectedColorName)
            
            Divider()
                .padding(.vertical, 4)
            
            HStack {
                Text("Icon")
                    .font(.title3)
                
                Spacer(minLength: 0)
                
                Image(systemName: selectedIconName)
                    .font(.title2)
                    .frame(width: 45, height: 45)
            }
            
            IconPickerView(selectedIconName: $selectedIconName, selectedCategoryColorName: $selectedColorName)
            
            Divider()
                .padding(.vertical, 4)
            
            HStack {
                Text("Preview")
                    .font(.title3)
                
                Spacer(minLength: 0)
                    
                Text(newCategoryName)
                
                CategoryButtonImageLayerView(
                    category: Category(
                        name: newCategoryName,
                        colorName: selectedColorName,
                        iconName: selectedIconName
                    ),
                    isSelected: true
                )
                .frame(width: 40)
                InfoCardBookmarkView(
                    category: Category(
                        name: newCategoryName,
                        colorName: selectedColorName,
                        iconName: selectedIconName
                    )
                )
                .offset(y: 3)
                
                
            }
            
            
        }
        .padding(.vertical, 6)
    }
}

struct IconPickerView: View {
    @Binding var selectedIconName: String
    @Binding var selectedCategoryColorName: String
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    private let iconNames: [String] = [
        // Movies / Shows
        "film.fill",
        "tv.fill",
        
        // Music / Audio
        "music.note.list",
        "music.mic",
        "headphones",
        "guitars.fill",
        
        // Wellness / Fitness / Health
        "figure.mind.and.body",
        "heart.fill",
        "bolt.heart.fill",
        "cross.case.fill",
        
        // Work / Productivity
        "briefcase.fill",
        "calendar",
        "clock.badge.checkmark",
        "chart.bar.xaxis",
        
        // Electronics / Tech / Gadgets
        "ipad.and.iphone",
        "desktopcomputer",
        "macbook.and.iphone",
        "gamecontroller.fill",
        
        // Restaurants / Food / Cooking
        "fork.knife",
        "takeoutbag.and.cup.and.straw.fill",
        "cup.and.saucer.fill",
        "birthday.cake.fill",
        "wineglass.fill",
        
        // Books / Reading / Learning
        "books.vertical.fill",
        "text.book.closed.fill",
        "bookmark.fill",
        "graduationcap.fill",
        
        // Art / Hobbies / Creative
        "paintpalette.fill",
        "pencil.and.outline",
        "scissors",
        "camera.fill",
        "photo.fill",
        
        // Sports
        "volleyball.fill",
        "tennisball.fill",
        "soccerball.circle.fill.inverse",
        "basketball.fill",
        
        // Memes / Fun / Entertainment
        "gift.fill",
        "face.smiling.inverse",
        "theatermasks.fill",
        "sparkles",
        "figure.stand.line.dotted.figure.stand",
        
        // Travel / Places / Outdoors
        "house.fill",
        "airplane",
        "car.fill",
        "bicycle",
        "map.fill",
        "location.fill",
        "mappin.and.ellipse",
        "binoculars.fill",
        "globe.americas.fill",
        "tent.fill",
        
        // Goods / Shopping / Products
        "tshirt.fill",
        "bag.fill",
        "cart.fill",
        "shippingbox.fill",
        "tag.fill",
        
        // Learning / Self-Development
        "brain.head.profile",
        "lightbulb.fill",
        "rectangle.stack.person.crop.fill",
        "questionmark.circle.fill",
        
        // Ideas / Notes / Writing
        "square.and.pencil",
        "note.text",
        "list.bullet.rectangle.fill",
        
        // Misc / Catch-All / Custom
        "square.grid.2x2.fill",
        "ellipsis.circle.fill",
        "questionmark.folder.fill",
        

        // Classic symbol for pets
        "pawprint.fill",
        "tortoise.fill",
        "hare.fill",
        "ant.fill",
        "ladybug.fill",
        "camera.macro",
        "rainbow",
        "tree.fill",
        "leaf.fill",
        "sun.max.fill",
        "moon.fill",
        "cloud.fill",
        "snowflake",
        "bird.fill",
        "fish.fill",
        "pawprint.fill",
        
        "questionmark"
    ]
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(iconNames, id: \.self) { iconName in
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Category(name: "", colorName: selectedCategoryColorName, iconName: "").color(for: userData.colorTheme, colorScheme: colorScheme))
                            .scaleEffect(selectedIconName == iconName ? 1.15 : 1)
                            .shadow(
                                color: (
                                    colorScheme == .light ? (
                                        Color.black.opacity(
                                            selectedIconName == iconName ? 0.17 : 0
                                        )
                                    ) : (
                                        Color.white.opacity(
                                            selectedIconName == iconName ? 0.17 : 0
                                        )
                                    )
                                ),
                                radius: 2,
                                y: 2
                            )
                        
                        Image(systemName: iconName)
                            .font(.title3)
                            .frame(width: 45, height: 45)
                            .foregroundStyle(colorScheme == .light ? .white : .black)
                            .scaleEffect(selectedIconName == iconName ? 1.15 : 1)
                    }
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedIconName = iconName
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}


struct CustomColorPickerView: View {
    @Binding var selectedColorName: String
    private let colorNames: [String] = ["green", "mint", "teal", "cyan", "blue", "indigo", "purple", "pink", "red", "orange", "yellow", "brown", "gray"]
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserDataManager.self) var userData
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(colorNames, id: \.self) { colorName in
                    ZStack {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundStyle(Category(name: "", colorName: colorName, iconName: "").color(for: userData.colorTheme, colorScheme: colorScheme))
                            .scaleEffect(selectedColorName == colorName ? 1.15 : 1)
                            .shadow(
                                color: .black.opacity(
                                    selectedColorName == colorName ? 0.17 : 0
                                ), radius: 2, y: 2
                            )
                        Image(systemName: "checkmark")
                            .bold()
                            .foregroundStyle(colorScheme == .light ? .white : .black)
                            .opacity(selectedColorName == colorName ? 1 : 0)
                    }
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedColorName = colorName
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}
