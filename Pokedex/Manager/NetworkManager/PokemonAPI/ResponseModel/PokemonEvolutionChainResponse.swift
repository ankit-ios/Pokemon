//
//  PokemonEvolutionChainResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

//MARK: - EvolutionChain

struct PokemonEvolutionChain: Decodable {
    
    let babyTriggerItem: String?
    let chain: Chain?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain
        case id
    }
}

extension PokemonEvolutionChain {
    struct Chain: Decodable {
        let evolutionDetails: [EvolutionDetails]?
        let evolvesTo: [Chain]?
        let isBaby: Bool?
        let species: PokemonNameURL?
        
        private enum CodingKeys: String, CodingKey {
            case evolutionDetails = "evolution_details"
            case evolvesTo = "evolves_to"
            case isBaby = "is_baby"
            case species
        }
    }
    
    struct EvolutionDetails: Decodable {
        let minLevel: Int?
        let gender: String?
        
        private enum CodingKeys: String, CodingKey {
            case minLevel = "min_level"
            case gender = "gender"
        }
    }
}
