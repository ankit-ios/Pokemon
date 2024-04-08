//
//  ButtonWithLabel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct ButtonWithLabel<LabelContent>: View where LabelContent: View {
    let disabled: Bool
    let label: () -> LabelContent
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            label()
        }
        .frame(height: 40)
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(disabled ? .gray : AppColors.Text.primary)
        )
        .padding()
        .disabled(disabled)
    }
}
