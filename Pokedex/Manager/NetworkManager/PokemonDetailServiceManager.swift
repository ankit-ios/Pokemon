//
//  PokemonDetailServiceManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation
import Combine

class PokemonDetailServiceManager {
    
    private let networkManager: NetworkManager
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension PokemonDetailServiceManager: PokemonDetailService {
    
    func fetchPokemonSpecies(pokemonId: Int, _ response: APIResponse<PokemonSpecies, NetworkError>?) async {
        networkManager.request(PokemonApi.species(pokemonId: pokemonId), responseType: PokemonSpecies.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { species in
                response?(.success(species))
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonTypeDetail(pokemonId: Int, _ response: APIResponse<PokemonTypeDetail, NetworkError>?) async {
        networkManager.request(PokemonApi.type(pokemonId: pokemonId), responseType: PokemonTypeDetail.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { typeDetail in
                response?(.success(typeDetail))
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonEvolutionChain(pokemonId: Int, _ response: APIResponse<PokemonEvolutionChain, NetworkError>?) async {
        networkManager.request(PokemonApi.evolutionChain(pokemonId: pokemonId), responseType: PokemonEvolutionChain.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { evolutionChain in
                response?(.success(evolutionChain))
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonDetail(pokemonId: String, _ response: APIResponse<PokemonDetail, NetworkError>?) async {
        networkManager.request(PokemonApi.detail(pokemonId: pokemonId), responseType: PokemonDetail.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { detail in
                response?(.success(detail))
            }
            .store(in: &networkManager.cancellables)
    }
}
