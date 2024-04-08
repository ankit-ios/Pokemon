//
//  LoadingView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    var body: some View {
        Text(HomeScreenLabels.loadingMore)
            .padding()
            .font(AppFont.caption)
            .foregroundColor(.white)
            .background(AppColors.Text.primary)
            .transition(.opacity)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 10)
            .opacity(show ? 1 : 0)
    }
}
