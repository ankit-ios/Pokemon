//
//  AppFonts.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct AppFont {
    
    enum RobotoFont: String {
        case robotoBlack = "Roboto-Black"
        case robotoBold = "Roboto-Bold"
        case robotoItalic = "Roboto-Italic"
        case robotoLight = "Roboto-Light"
        case robotoMedium = "Roboto-Medium"
        case robotoRegular = "Roboto-Regular"
        case robotoThin = "Roboto-Thin"
    }
    
    static let navigationTitle = AppFont.font(.robotoBlack, with: 30)
    static let title = AppFont.font(.robotoBlack, with: 25)
    static let subtitle = AppFont.font(.robotoBold, with: 18)
    static let body = AppFont.font(.robotoMedium, with: 16)
    static let caption = AppFont.font(.robotoRegular, with: 16)
}

extension AppFont {
    
    static func font(_ name: RobotoFont, with size: CGFloat) -> Font {
        Font.custom(name.rawValue, size: size)
    }
}
