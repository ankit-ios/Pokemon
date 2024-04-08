//
//  PokemonTypeDetailResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

//MARK: - Type

struct PokemonTypeDetail: Decodable {
    
    let damageRelations: DamageRelations?
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }
}

extension PokemonTypeDetail {
    struct DamageRelations: Decodable {
        let doubleDamageFrom: [PokemonNameURL]?
        let halfDamageFrom: [PokemonNameURL]?
        let doubleDamageTo: [PokemonNameURL]?
        let halfDamageTo: [PokemonNameURL]?
        
        enum CodingKeys: String, CodingKey {
            case doubleDamageFrom = "double_damage_from"
            case halfDamageFrom = "half_damage_from"
            case doubleDamageTo = "double_damage_to"
            case halfDamageTo = "half_damage_to"
        }
    }
}
