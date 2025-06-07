//
//  Category.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI
import SwiftData

@Model
class Category: Identifiable {
    var name: String
    var colorName: String // Store only the name of the color
    var iconName: String

    init(name: String, colorName: String, iconName: String) {
        self.name = name
        self.colorName = colorName
        self.iconName = iconName
    }

    // Computed property to use the SwiftUI Color
    
    var color: Color {
        Color.named(colorName)
    }
}

extension Category: Hashable, Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name &&
        lhs.colorName == rhs.colorName &&
        lhs.iconName == rhs.iconName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(colorName)
        hasher.combine(iconName)
    }
}

extension Color {
    static func named(_ name: String, colorMode: ColorMode = .bright, colorScheme: ColorScheme = .light) -> Color {
        switch name.lowercased() {
        case "purple":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.6395432949, green: 0.3417222202, blue: 0.8382933736, alpha: 1)) : Color(#colorLiteral(red: 0.6395431757, green: 0.3417224884, blue: 0.8424218297, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.6653697491, green: 0.5239259601, blue: 0.7522006631, alpha: 1)) : Color(#colorLiteral(red: 0.6653697491, green: 0.5239259601, blue: 0.7522006631, alpha: 1))
            }
        case "pink":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.9214517474, green: 0.2738124132, blue: 0.3533887267, alpha: 1)) : Color(#colorLiteral(red: 0.9257770181, green: 0.273127377, blue: 0.3622042537, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.7945604324, green: 0.5003149509, blue: 0.5510149598, alpha: 1)) : Color(#colorLiteral(red: 0.794560492, green: 0.5003148913, blue: 0.5466868877, alpha: 1))
            }
        case "red":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.9240514636, green: 0.3075509071, blue: 0.2360424101, alpha: 1)) : Color(#colorLiteral(red: 0.9240514636, green: 0.3075509071, blue: 0.2360424101, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.7905866504, green: 0.4963668585, blue: 0.4728358388, alpha: 1)) : Color(#colorLiteral(red: 0.7905866504, green: 0.4963668585, blue: 0.4728358388, alpha: 1))
            }
        case "orange":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.9466544986, green: 0.6040715575, blue: 0.2187464833, alpha: 1)) : Color(#colorLiteral(red: 0.8494848609, green: 0.4839962125, blue: 0.04665285349, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.7106801867, green: 0.5546830297, blue: 0.3176420927, alpha: 1)) : Color(#colorLiteral(red: 0.710680306, green: 0.55468297, blue: 0.3127413392, alpha: 1))
            }
        case "yellow":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.7244343758, green: 0.5540227294, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.8741448522, green: 0.6744581461, blue: 0.01837625727, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.6515266299, green: 0.5777419209, blue: 0.2662667632, alpha: 1)) : Color(#colorLiteral(red: 0.6515265703, green: 0.5777419209, blue: 0.2714696825, alpha: 1))
            }
        case "green":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.2851462364, green: 0.651281774, blue: 0.2844724655, alpha: 1)) : Color(#colorLiteral(red: 0.2851462364, green: 0.651281774, blue: 0.2844724655, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.427749753, green: 0.6249081492, blue: 0.4561893344, alpha: 1)) : Color(#colorLiteral(red: 0.4223242998, green: 0.6250226498, blue: 0.451788187, alpha: 1))
            }
        case "mint":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.2407142222, green: 0.6318485737, blue: 0.6103125811, alpha: 1)) : Color(#colorLiteral(red: 0.2407142222, green: 0.6318485737, blue: 0.6103125811, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.3679010868, green: 0.6220710874, blue: 0.6143921018, alpha: 1)) : Color(#colorLiteral(red: 0.3679010868, green: 0.6220710874, blue: 0.6143921018, alpha: 1))
            }
        case "teal":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.2967283726, green: 0.6191977859, blue: 0.7044606209, alpha: 1)) : Color(#colorLiteral(red: 0.2967283726, green: 0.6191977859, blue: 0.7044606209, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.4265350103, green: 0.6128994226, blue: 0.6486555934, alpha: 1)) : Color(#colorLiteral(red: 0.4265350103, green: 0.6128994226, blue: 0.6486555934, alpha: 1))
            }
        case "cyan":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.2966841459, green: 0.607218802, blue: 0.8144047856, alpha: 1)) : Color(#colorLiteral(red: 0.2966841459, green: 0.607218802, blue: 0.8144047856, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.4371981621, green: 0.5965992808, blue: 0.696336925, alpha: 1)) : Color(#colorLiteral(red: 0.4371981621, green: 0.5965992808, blue: 0.696336925, alpha: 1))
            }
        case "blue":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.2036252022, green: 0.4687247276, blue: 0.9697249532, alpha: 1)) : Color(#colorLiteral(red: 0.2036252022, green: 0.4687247276, blue: 0.9697249532, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.4239582419, green: 0.5888726115, blue: 0.8145313859, alpha: 1)) : Color(#colorLiteral(red: 0.4239582419, green: 0.5888726115, blue: 0.8145313859, alpha: 1))
            }
        case "gray":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.5616611838, green: 0.5566973686, blue: 0.5825654268, alpha: 1)) : Color(#colorLiteral(red: 0.5616611838, green: 0.5566973686, blue: 0.5825654268, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.5773477554, green: 0.5723836422, blue: 0.5939647555, alpha: 1)) : Color(#colorLiteral(red: 0.5773477554, green: 0.5723836422, blue: 0.5939647555, alpha: 1))
            }
        case "brown":
            switch colorMode {
            case .bright:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.6152051091, green: 0.5220509171, blue: 0.387039423, alpha: 1)) : Color(#colorLiteral(red: 0.6152051091, green: 0.5220509171, blue: 0.387039423, alpha: 1))
            case .pastel:
                return colorScheme == .light ? Color(#colorLiteral(red: 0.6240792871, green: 0.5747430921, blue: 0.5104632974, alpha: 1)) : Color(#colorLiteral(red: 0.6240792871, green: 0.5747430921, blue: 0.5104632974, alpha: 1))
            }
            
            
//        case "red": return .red
//        case "blue": return .blue
//        case "green": return .green
//        case "orange": return .orange
//        case "pink": return .pink
//        case "purple": return .purple
//        case "yellow": return .yellow
//        case "mint": return .mint
//        case "teal": return .teal
//        case "indigo": return .indigo
//        case "cyan": return .cyan
        
//        case "brown": return .brown
//        case "gray": return .gray
        default: return .gray
        }
    }
}

// "purple",
//"pink",
//"red",
//"orange",
//"yellow",
//"green",
//"mint",
// "teal", "cyan", "blue", "brown", "gray"

enum ColorMode {
    case bright
    case pastel
}
