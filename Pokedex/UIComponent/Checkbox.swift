//
//  Checkbox.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI

struct CheckboxView: View {
    
    let text: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Button(action: { isChecked.toggle() }) {
                (isChecked ? AppImages.checkboxFill : AppImages.checkbox)
            }
            Text(text)
                .font(AppFont.caption)
        }
        .foregroundColor(AppColors.Text.primary)
    }
}
