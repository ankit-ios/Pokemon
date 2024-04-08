//
//  PokemonListServiceManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation
import Combine

class PokemonListServiceManager {
    
    var offset: Int = 0
    var limit: Int = 20
    private let networkManager: NetworkManager
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension PokemonListServiceManager: PokemonListService {
    
    func fetchPokemonList(_ response: APIResponse<PokemonListResponse, NetworkError>?) async {
        networkManager.request(PokemonApi.list(offset: offset, limit: limit), responseType: PokemonListResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { listResponse in
                response?(.success(listResponse))
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchNextPagePokemonList(_ response: APIResponse<PokemonListResponse, NetworkError>?) async {
        self.offset += 20
        networkManager.request(PokemonApi.list(offset: offset, limit: limit), responseType: PokemonListResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure:
                    response?(.failure(NetworkError.failed))
                }
            }) { listResponse in
                response?(.success(listResponse))
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonItemDetail(pokemonId: Int, _ item: PokemonItem, response: APIResponse<PokemonDetail, NetworkError>?) async {
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
