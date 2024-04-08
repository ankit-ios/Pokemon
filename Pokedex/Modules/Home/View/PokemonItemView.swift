//
//  PokemonItemView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonItemView: View {
    let pokemon: PokemonDetail?
    
    var body: some View {
        
        VStack {
            if let pokemon = pokemon {
                VStack {
                    Spacer()
                    AsyncImage(url: URL(string: pokemon.sprites.thumbnail ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(1.1, contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    Text(pokemon.name?.capitalized ?? "")
                        .font(AppFont.body)
                        .foregroundColor(AppColors.Text.primary)
                    Text(String(format: "%03d", pokemon.id))
                        .font(AppFont.caption)
                        .foregroundColor(AppColors.Text.primary)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .center)
                .addGradient(colors: pokemon.gradientColors)
                .dottedBorder(color: .black, lineWidth: 1, dash: [5, 5], cornerRadius: 12)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct PokemonItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: .dummy)
    }
}
