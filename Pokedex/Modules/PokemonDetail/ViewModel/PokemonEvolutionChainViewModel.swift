//
//  PokemonEvolutionChainViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation

struct PokemonEvolutionChainViewModel {
    private let pokemonEvolutionChain: PokemonEvolutionChain
    
    init(pokemonEvolutionChain: PokemonEvolutionChain) {
        self.pokemonEvolutionChain = pokemonEvolutionChain
    }
    
    func getAllSpecies() -> [PokemonNameURL] {
        guard
            let chain = self.pokemonEvolutionChain.chain
        else { return [] }
        return getSpecies(from: chain)
    }
    
    /// private recursive func to get all species from `chain`
    private func getSpecies(from chain: PokemonEvolutionChain.Chain) -> [PokemonNameURL] {
        var allSpecies: [PokemonNameURL] = []
        guard let species = chain.species else { return allSpecies }
        allSpecies.append(species)
        
        guard let nextChain = chain.evolvesTo?.first else { return allSpecies }
        allSpecies.append(contentsOf: getSpecies(from: nextChain))
        return allSpecies
    }
}
