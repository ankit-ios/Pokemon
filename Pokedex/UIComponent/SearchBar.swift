//
//  SearchBar.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    let searchAction: () -> Void
    
    
    var body: some View {
        HStack {
            AppImages.search
                .foregroundColor(searchText.isEmpty ? AppColors.Text.primary.opacity(0.5) : AppColors.Text.primary)
            
            TextField(HomeScreenLabels.searchPlaceholder, text: $searchText)
                .textFieldStyle(.plain)
                .overlay(
                    AppImages.closeFill
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing)
                .onChange(of: searchText) { newValue in
                    searchText = newValue
                }
            
        }
        .font(AppFont.body)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.Background.secondary)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 2, y: 0)
        )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), searchAction: {})
    }
}
