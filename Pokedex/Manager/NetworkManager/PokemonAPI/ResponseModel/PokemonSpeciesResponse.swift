//
//  PokemonSpeciesResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

// MARK: - Species

struct PokemonSpecies: Decodable {
    let eggGroup: [PokemonNameURL]?
    let flavorTextEntries: [FlavorTextEntries]?
    
    
    enum CodingKeys: String, CodingKey {
        case eggGroup = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
    }
}

extension PokemonSpecies {
    struct FlavorTextEntries: Decodable {
        let flavorText: String?
        let language: PokemonNameURL?
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
}
