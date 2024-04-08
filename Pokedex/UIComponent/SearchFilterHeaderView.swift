//
//  SearchFilterHeaderView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import SwiftUI

struct SearchFilterHeaderView: View {
    @Binding var searchQuery: String
    let searchAction: () -> Void
    let filterAction: () -> Void

    var body: some View {
        HStack {
            // search bar
            SearchBar(searchText: $searchQuery, searchAction: searchAction)
                .padding(.leading, 5)
            
            // Filter Button
            Button(action: filterAction) {
                AppImages.filter
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 60, height: 50)
            .background(AppColors.Text.primary)
            .cornerRadius(10)
        }
    }
}
