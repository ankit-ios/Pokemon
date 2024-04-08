//
//  PokemonDetailHeadingView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailHeadingView: View {
    
    let pokemonDetail: PokemonDetail
    @Binding var pokemonSpices: PokemonSpeciesViewModel?
    let showFullDescriptionView: ((String) -> (Void))
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 20) {
                
                ImageViewWithGradient(imageURL: pokemonDetail.sprites.actualImage ?? "", gradientColors: pokemonDetail.gradientColors)
                    .frame(width: geometry.size.width*0.5, height: geometry.size.height)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(pokemonSpices?.getFlavorText() ?? "")
                        .font(AppFont.caption)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.top, 8)
                    
                    // read more button
                    Button(action: {
                        showFullDescriptionView(pokemonSpices?.getFullFlavorTexts() ?? "")
                    }) {
                        Text(DetailScreenLabels.readMoreButton)
                            .font(AppFont.body)
                            .foregroundColor(AppColors.Text.primary)
                            .underline()
                    }
                    Spacer()
                }
                .animation(.default)
            }
        }
    }
}

struct PokemonDetailHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailHeadingView(pokemonDetail: .dummy, pokemonSpices: .constant(nil), showFullDescriptionView: { _ in })
    }
}

