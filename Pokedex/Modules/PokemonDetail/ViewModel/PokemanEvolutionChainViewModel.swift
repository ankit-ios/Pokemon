//
//  PokemanEvolutionChainViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import Foundation

class PokemanEvolutionChainViewModel: ObservableObject {
    
    private let pokemonNavigation: PokemonBottomNavigation
    
    init(pokemonNavigation: PokemonBottomNavigation) {
        self.pokemonNavigation = pokemonNavigation
    }
    
    func selectedPokemon() -> PokemonDetail {
        pokemonNavigation.selectedPokemon
    }
    
    func getPreviousPokemanId() -> Int? {
        (selectedPokemon().id > 1) ? (selectedPokemon().id - 1) : nil
    }
    
    func getNextPokemanId() -> Int {
        (selectedPokemon().id + 1)
    }
    
    func getPreviousPokemanName() -> String {
        pokemonNavigation.previousPokemon?.capitalized ?? ""
    }
    
    func getNextPokemanName() -> String {
        pokemonNavigation.nextPokemon?.capitalized ?? ""
    }
    
    func shouldDisablePreviousButton() -> Bool {
        getPreviousPokemanName().isEmpty
    }
    
    func shouldDisableNextButton() -> Bool {
        getNextPokemanName().isEmpty
    }
}
