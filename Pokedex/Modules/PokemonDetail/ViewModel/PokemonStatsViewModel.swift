//
//  PokemonStatsViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

struct PokemonStatsViewModel {
    
    struct Stats {
        let id = UUID()
        let name: String
        let percentage: Int
    }
    
    private let pokemonDetail: PokemonDetail
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    func getPokemenStats() -> [PokemonStatsViewModel.Stats] {
        let statsArray: [Stats] = pokemonDetail.stats.compactMap { stat in
            guard let name = stat.stat?.name else { return nil }
            return Stats(name: name, percentage: stat.baseStat ?? 0)
        }
        
        return statsArray
    }
}
