//
//  PokemonGenderResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

//MARK: - Gender

struct PokemonGenderResponse: Decodable {
    let gender: String
    let speciesDetails: [PokemonGenderSpeciesDetails]?
    var allSpecies: [String] {
        speciesDetails?.compactMap { $0.pokemonSpecies?.name } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case gender = "name"
        case speciesDetails = "pokemon_species_details"
    }
}

extension PokemonGenderResponse {
    struct PokemonGenderSpeciesDetails: Decodable {
        let pokemonSpecies: PokemonGenderSpecies?
        
        enum CodingKeys: String, CodingKey {
            case pokemonSpecies = "pokemon_species"
        }
    }
    
    struct PokemonGenderSpecies: Decodable {
        let name: String?
    }
}
