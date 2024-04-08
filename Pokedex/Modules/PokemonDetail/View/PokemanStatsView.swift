//
//  PokemanStatsView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanStatsView: View {
    
    let statsModel: PokemonStatsViewModel
    
    private var stats: [PokemonStatsViewModel.Stats] {
        statsModel.getPokemenStats()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(DetailScreenLabels.statsLabel)
                .font(AppFont.subtitle)
                        
            ForEach(stats, id: \.name) { item in
                
                HStack(alignment: .center, spacing: 2) {
                    Text(item.name.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(AppFont.caption)
                    Spacer()
                    ProgressBarView(progress: item.percentage)
                        .frame(height: 20)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding()
        .background(AppColors.Background.tertiary)
    }
}

struct PokemanStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanStatsView(statsModel: .init(pokemonDetail: .dummy))
    }
}
