//
//  DottedBorder.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct DottedBorder: View {
    var color: Color
    var lineWidth: CGFloat
    var dash: [CGFloat]
    var cornerRadius: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, dash: dash))
            .foregroundColor(color)
    }
}

struct DottedBorderModifier: ViewModifier {
    var color: Color
    var lineWidth: CGFloat
    var dash: [CGFloat]
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(DottedBorder(color: color, lineWidth: lineWidth, dash: dash, cornerRadius: cornerRadius))
            .cornerRadius(12)
            .shadow(color: AppColors.Text.primary.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func dottedBorder(color: Color = .blue, lineWidth: CGFloat = 2, dash: [CGFloat] = [5, 5], cornerRadius: CGFloat = 12) -> some View {
        self.modifier(DottedBorderModifier(color: color, lineWidth: lineWidth, dash: dash, cornerRadius: cornerRadius))
    }
}
