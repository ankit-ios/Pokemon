//
//  PrimaryButtonStyle.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.caption)
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(configuration.isPressed ? AppColors.Background.primary: AppColors.Text.primary)
            .foregroundColor(configuration.isPressed ? AppColors.Text.primary: AppColors.Background.primary)
            .cornerRadius(12)
    }
}
