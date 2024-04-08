//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Ankit Sharma on 30/10/23.
//

import Foundation
import Combine

protocol PokemonListService {
    func fetchPokemonList(_ response: APIResponse<PokemonListResponse, NetworkError>?) async
    func fetchNextPagePokemonList(_ response: APIResponse<PokemonListResponse, NetworkError>?) async
    func fetchPokemonItemDetail(pokemonId: Int, _ item: PokemonItem, response: APIResponse<PokemonDetail, NetworkError>?) async
}


protocol PokemonDetailService {
    func fetchPokemonSpecies(pokemonId: Int, _ response: APIResponse<PokemonSpecies, NetworkError>?) async
    func fetchPokemonTypeDetail(pokemonId: Int, _ response: APIResponse<PokemonTypeDetail, NetworkError>?) async
    func fetchPokemonEvolutionChain(pokemonId: Int, _ response: APIResponse<PokemonEvolutionChain, NetworkError>?) async
    func fetchPokemonDetail(pokemonId: String, _ response: APIResponse<PokemonDetail, NetworkError>?) async
}
