//
//  PokemonApi.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation

enum PokemonApi: APIRequest {
    case list(offset: Int, limit: Int)
    case detail(pokemonId: Any) /// `id` can be String or Int
    case gender(type: String)
    case species(pokemonId: Int)
    case type(pokemonId: Int)
    case evolutionChain(pokemonId: Int)
    
    var endpoint: String {
        switch self {
        case .list: return "/pokemon"
        case .detail(let pokemonId): return "/pokemon/\(String.convertAnyToString(pokemonId) ?? "")"
        case .gender(let type): return "/gender/\(type)"
        case .species(let pokemonId): return "/pokemon-species/\(pokemonId)"
        case .type(let pokemonId): return "/type/\(pokemonId)"
        case .evolutionChain(let pokemonId): return "/evolution-chain/\(pokemonId)"
        }
    }
    
    var requestParameters: [String: Any]? {
        switch self {
        case .list(let offset, let limit):
            return ["offset": offset, "limit": limit]
        default: return nil
        }
    }
}
