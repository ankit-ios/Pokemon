//
//  ImageViewWithGradient.swift
//  Pokedex
//
//  Created by Ankit Sharma on 25/10/23.
//

import SwiftUI

struct ImageViewWithGradient: View {
    
    let imageURL: String
    let gradientColors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            
            AsyncImage(url: (URL(string: imageURL))) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .addGradient(colors: gradientColors)
            .dottedBorder(color: .black, lineWidth: 1, dash: [5, 5], cornerRadius: 12)
        }
    }
}
