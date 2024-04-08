//
//  Pokemon+Extensions.swift
//  Pokedex
//
//  Created by Ankit Sharma on 22/10/23.
//

import SwiftUI

//MARK: - String Extension

extension String {
    static func convertAnyToString(_ value: Any) -> String? {
        if let stringValue = value as? String {
            return stringValue
        } else if let intValue = value as? Int {
            return "\(intValue)"
        } else {
            return nil
        }
    }
    
    func getId() -> Int? {
        guard let url = URL(string: self),
              let id = Int(url.lastPathComponent)
        else { return nil }
        return id
    }
}

//MARK: - View Extension

extension View {
    func addGradient(colors: [Color]) -> some View {
        let gradient = LinearGradient(gradient: Gradient(colors: colors),
                                      startPoint: .top,
                                      endPoint: .bottom)
        return self.background(gradient)
    }
    
    func removeGradient() -> some View {
        return self
    }
}

//MARK: - Color Extension

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        // Skip the '#' character
        scanner.currentIndex = hex.index(after: hex.startIndex)
        
        // Read the hex value
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

//MARK: - UIApplication Extension

extension UIApplication {
    
    ///dismiss the keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: - Image Extension
extension Image {
    @MainActor
    func asUIImage(newSize: CGSize) -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .frame(width: newSize.width, height: newSize.height)
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}

//MARK: - LabelStyle
struct TitleIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .font(AppFont.caption)
                .foregroundColor(.white)
            configuration.icon
                .foregroundColor(.white)
        }
    }
}
