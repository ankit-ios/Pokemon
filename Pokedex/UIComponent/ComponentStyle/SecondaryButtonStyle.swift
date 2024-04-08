//
//  SecondaryButtonStyle.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.caption)
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(configuration.isPressed ? AppColors.Text.primary : AppColors.Background.primary)
            .foregroundColor(configuration.isPressed ? AppColors.Background.primary : AppColors.Text.primary)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.Text.primary, lineWidth: 1)
            )
    }
}
