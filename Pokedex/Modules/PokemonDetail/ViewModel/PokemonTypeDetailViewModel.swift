//
//  PokemonTypeDetailViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

struct PokemonTypeDetailViewModel {
    
    private let pokemonTypeDetail: PokemonTypeDetail
    
    init(pokemonTypeDetail: PokemonTypeDetail) {
        self.pokemonTypeDetail = pokemonTypeDetail
    }
    
    func getPokemenWeakAgainst() -> [String] {
        guard let relation = pokemonTypeDetail.damageRelations else { return [] }
        
        let allDamageTypes = (relation.doubleDamageFrom ?? []) + (relation.halfDamageFrom ?? []) + (relation.doubleDamageTo ?? []) + (relation.halfDamageTo ?? [])
        
        let uniqueDamageTypes = Array(Set(allDamageTypes.compactMap { $0.name }))
        
        return uniqueDamageTypes
    }
}
