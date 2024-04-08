//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

//MARK: - List
struct PokemonListResponse: Decodable {
    let next: String
    let results: [PokemonItem]
}

struct PokemonItem: Decodable, Hashable, Equatable {
    let name: String
    let url: String
    var thumbnail: String?
}

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonNameURL?
}

struct PokemonNameURL: Decodable {
    let name: String?
    let url: String?
}

