//
//  PokemonDetailServiceMockServer.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation
@testable import Pokedex

class PokemonDetailServiceMockServer: PokemonDetailService {
    
    func fetchPokemonSpecies(pokemonId: Int,
                             _ response: Pokedex.APIResponse<Pokedex.PokemonSpecies, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.species),
           let model = try? JSONDecoder().decode(Pokedex.PokemonSpecies.self, from: data) {
            response?(.success(model))
        } else {
            response?(.failure(.badRequest))
        }
    }
    
    func fetchPokemonTypeDetail(pokemonId: Int,
                                _ response: Pokedex.APIResponse<Pokedex.PokemonTypeDetail, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.typeDetail),
           let model = try? JSONDecoder().decode(Pokedex.PokemonTypeDetail.self, from: data) {
            response?(.success(model))
        } else {
            response?(.failure(.badRequest))
        }
    }
    
    func fetchPokemonEvolutionChain(pokemonId: Int,
                                    _ response: Pokedex.APIResponse<Pokedex.PokemonEvolutionChain, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.evolution),
           let model = try? JSONDecoder().decode(Pokedex.PokemonEvolutionChain.self, from: data) {
            response?(.success(model))
        } else {
            response?(.failure(.badRequest))
        }
    }
    
    func fetchPokemonDetail(pokemonId: String,
                            _ response: Pokedex.APIResponse<Pokedex.PokemonDetail, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.detail),
           let model = try? JSONDecoder().decode(Pokedex.PokemonDetail.self, from: data) {
            response?(.success(model))
        } else {
            response?(.failure(.badRequest))
        }
    }
}
