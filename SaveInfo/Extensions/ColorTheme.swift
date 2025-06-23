//
//  ColorTheme.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 17/06/25.
//
import SwiftUI

enum ColorTheme: String, Codable, CaseIterable {
    case bright
    case pastel
    
    var name: String {
        switch self {
        case .bright:
            return "Bright"
        case .pastel:
            return"Pastel"
        }
    }
}

extension Color {
    
    static func named(_ name: String, colorTheme: ColorTheme, colorScheme: ColorScheme ) -> Color {
        switch colorTheme {
            
        case .bright:
            
            switch name.lowercased() {
                
            case "green":  return colorScheme == .light ? Color(#colorLiteral(red: 0.2851462364, green: 0.651281774, blue: 0.2844724655, alpha: 1)) : Color(#colorLiteral(red: 0.2851462364, green: 0.651281774, blue: 0.2844724655, alpha: 1))
            case "mint":   return colorScheme == .light ? Color(#colorLiteral(red: 0.2407142222, green: 0.6318485737, blue: 0.6103125811, alpha: 1)) : Color(#colorLiteral(red: 0.2407142222, green: 0.6318485737, blue: 0.6103125811, alpha: 1))
            case "teal":   return colorScheme == .light ? Color(#colorLiteral(red: 0.2967283726, green: 0.6191977859, blue: 0.7044606209, alpha: 1)) : Color(#colorLiteral(red: 0.2967283726, green: 0.6191977859, blue: 0.7044606209, alpha: 1))
            case "cyan":   return colorScheme == .light ? Color(#colorLiteral(red: 0.2966841459, green: 0.607218802, blue: 0.8144047856, alpha: 1)) : Color(#colorLiteral(red: 0.2966841459, green: 0.607218802, blue: 0.8144047856, alpha: 1))
            case "blue":   return colorScheme == .light ? Color(#colorLiteral(red: 0.2036252022, green: 0.4687247276, blue: 0.9697249532, alpha: 1)) : Color(#colorLiteral(red: 0.2036252022, green: 0.4687247276, blue: 0.9697249532, alpha: 1))
            case "indigo": return colorScheme == .light ? Color(#colorLiteral(red: 0.3468087614, green: 0.3369399607, blue: 0.8411970139, alpha: 1)) : Color(#colorLiteral(red: 0.3468087614, green: 0.3369399607, blue: 0.8411970139, alpha: 1))
            case "purple": return colorScheme == .light ? Color(#colorLiteral(red: 0.6395432949, green: 0.3417222202, blue: 0.8382933736, alpha: 1)) : Color(#colorLiteral(red: 0.6395431757, green: 0.3417224884, blue: 0.8424218297, alpha: 1))
            case "pink":   return colorScheme == .light ? Color(#colorLiteral(red: 0.9214517474, green: 0.2738124132, blue: 0.3533887267, alpha: 1)) : Color(#colorLiteral(red: 0.9257770181, green: 0.273127377, blue: 0.3622042537, alpha: 1))
            case "red":    return colorScheme == .light ? Color(#colorLiteral(red: 0.9240514636, green: 0.3075509071, blue: 0.2360424101, alpha: 1)) : Color(#colorLiteral(red: 0.9240514636, green: 0.3075509071, blue: 0.2360424101, alpha: 1))
            case "orange": return colorScheme == .light ? Color(#colorLiteral(red: 0.9466544986, green: 0.6040715575, blue: 0.2187464833, alpha: 1)) : Color(#colorLiteral(red: 0.8494848609, green: 0.4839962125, blue: 0.04665285349, alpha: 1))
            case "yellow": return colorScheme == .light ? Color(#colorLiteral(red: 0.7244343758, green: 0.5540227294, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 0.8741448522, green: 0.6744581461, blue: 0.01837625727, alpha: 1))
            case "brown":  return colorScheme == .light ? Color(#colorLiteral(red: 0.6152051091, green: 0.5220509171, blue: 0.387039423, alpha: 1)) : Color(#colorLiteral(red: 0.6152051091, green: 0.5220509171, blue: 0.387039423, alpha: 1))
            case "gray":   return colorScheme == .light ? Color(#colorLiteral(red: 0.5616611838, green: 0.5566973686, blue: 0.5825654268, alpha: 1)) : Color(#colorLiteral(red: 0.5616611838, green: 0.5566973686, blue: 0.5825654268, alpha: 1))
            
            default: return .gray
                
            }
            
        case .pastel:
            
            switch name.lowercased() {
                
            case "green":  return colorScheme == .light ? Color(#colorLiteral(red: 0.427749753, green: 0.6249081492, blue: 0.4561893344, alpha: 1)) : Color(#colorLiteral(red: 0.4223242998, green: 0.6250226498, blue: 0.451788187, alpha: 1))
            case "mint":   return colorScheme == .light ? Color(#colorLiteral(red: 0.3679010868, green: 0.6220710874, blue: 0.6143921018, alpha: 1)) : Color(#colorLiteral(red: 0.3679010868, green: 0.6220710874, blue: 0.6143921018, alpha: 1))
            case "teal":   return colorScheme == .light ? Color(#colorLiteral(red: 0.4265350103, green: 0.6128994226, blue: 0.6486555934, alpha: 1)) : Color(#colorLiteral(red: 0.4265350103, green: 0.6128994226, blue: 0.6486555934, alpha: 1))
            case "cyan":   return colorScheme == .light ? Color(#colorLiteral(red: 0.4371981621, green: 0.5965992808, blue: 0.696336925, alpha: 1)) : Color(#colorLiteral(red: 0.4371981621, green: 0.5965992808, blue: 0.696336925, alpha: 1))
            case "blue":   return colorScheme == .light ? Color(#colorLiteral(red: 0.4239582419, green: 0.5888726115, blue: 0.8145313859, alpha: 1)) : Color(#colorLiteral(red: 0.4239582419, green: 0.5888726115, blue: 0.8145313859, alpha: 1))
            case "indigo": return colorScheme == .light ? Color(#colorLiteral(red: 0.5568627451, green: 0.5529411765, blue: 0.8156862745, alpha: 1)) : Color(#colorLiteral(red: 0.568627451, green: 0.5647058824, blue: 0.8196078431, alpha: 1))
            case "purple": return colorScheme == .light ? Color(#colorLiteral(red: 0.6653697491, green: 0.5239259601, blue: 0.7522006631, alpha: 1)) : Color(#colorLiteral(red: 0.6653697491, green: 0.5239259601, blue: 0.7522006631, alpha: 1))
            case "pink":   return colorScheme == .light ? Color(#colorLiteral(red: 0.7945604324, green: 0.5003149509, blue: 0.5510149598, alpha: 1)) : Color(#colorLiteral(red: 0.794560492, green: 0.5003148913, blue: 0.5466868877, alpha: 1))
            case "red":    return colorScheme == .light ? Color(#colorLiteral(red: 0.7905866504, green: 0.4963668585, blue: 0.4728358388, alpha: 1)) : Color(#colorLiteral(red: 0.7905866504, green: 0.4963668585, blue: 0.4728358388, alpha: 1))
            case "orange": return colorScheme == .light ? Color(#colorLiteral(red: 0.7106801867, green: 0.5546830297, blue: 0.3176420927, alpha: 1)) : Color(#colorLiteral(red: 0.710680306, green: 0.55468297, blue: 0.3127413392, alpha: 1))
            case "yellow": return colorScheme == .light ? Color(#colorLiteral(red: 0.6515266299, green: 0.5777419209, blue: 0.2662667632, alpha: 1)) : Color(#colorLiteral(red: 0.6515265703, green: 0.5777419209, blue: 0.2714696825, alpha: 1))
            case "brown":  return colorScheme == .light ? Color(#colorLiteral(red: 0.6240792871, green: 0.5747430921, blue: 0.5104632974, alpha: 1)) : Color(#colorLiteral(red: 0.6240792871, green: 0.5747430921, blue: 0.5104632974, alpha: 1))
            case "gray":   return colorScheme == .light ? Color(#colorLiteral(red: 0.5773477554, green: 0.5723836422, blue: 0.5939647555, alpha: 1)) : Color(#colorLiteral(red: 0.5773477554, green: 0.5723836422, blue: 0.5939647555, alpha: 1))
                
            default: return .gray
                
            }
        }
        
    }
}
