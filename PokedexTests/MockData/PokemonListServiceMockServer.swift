//
//  PokemonListServiceMockServer.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation
@testable import Pokedex

class PokemonListServiceMockServer: PokemonListService {
    func fetchPokemonList(_ response: Pokedex.APIResponse
                          <Pokedex.PokemonListResponse, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.list),
           let list = try? JSONDecoder().decode(Pokedex.PokemonListResponse.self, from: data) {
            response?(.success(list))
        } else {
            response?(.failure(.badRequest))
        }
    }
    func fetchNextPagePokemonList(_ response: Pokedex.APIResponse
                                  <Pokedex.PokemonListResponse, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.list),
           let list = try? JSONDecoder().decode(Pokedex.PokemonListResponse.self, from: data) {
            response?(.success(list))
        } else {
            response?(.failure(.badRequest))
        }
    }
    func fetchPokemonItemDetail(pokemonId: Int, _ item: Pokedex.PokemonItem,
                                response: Pokedex.APIResponse<Pokedex.PokemonDetail, Pokedex.NetworkError>?) async {
        print(#function)
        if let data = JSONReader.load(.detail),
           let detail = try? JSONDecoder().decode(Pokedex.PokemonDetail.self, from: data) {
            response?(.success(detail))
        } else {
            response?(.failure(.badRequest))
        }
    }
}
