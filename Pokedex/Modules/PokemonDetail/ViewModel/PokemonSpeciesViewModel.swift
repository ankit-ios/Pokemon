//
//  PokemonSpeciesViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

struct PokemonSpeciesViewModel {
    
    private let pokemonSpecies: PokemonSpecies
    
    init(pokemonSpecies: PokemonSpecies) {
        self.pokemonSpecies = pokemonSpecies
    }
    
    func getFlavorText() -> String {
        pokemonSpecies.flavorTextEntries?.filter { $0.language?.name == "en" }.first?.flavorText ?? ""
    }
    
    func getFullFlavorTexts() -> String {
        let flavorTexts = pokemonSpecies.flavorTextEntries?
            .filter { $0.language?.name == "en" }
            .compactMap { $0 }
            .map { $0.flavorText ?? "" } ?? []

        let concatenatedText = flavorTexts.reduce("") { $0 + $1 }

        // Remove newline characters
        let textWithoutNewlines = concatenatedText.replacingOccurrences(of: "\n", with: " ")

        return textWithoutNewlines
    }
    
    func getEggGroups() -> [String] {
        pokemonSpecies.eggGroup?.compactMap { $0.name } ?? []
    }
}
