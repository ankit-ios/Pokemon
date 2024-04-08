//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    @Published var pokemonSpeciesModel: PokemonSpeciesModel?
    @Published var pokemonTypeDetailModel: PokemonTypeDetailModel?
    @Published var pokemonEvolutionChainModel: PokemonEvolutionChainModel?
    @Published var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    
    private let dispatchGroup = DispatchGroup()
    private var chainDetailList: [PokemonDetail] = []
    
    
    func fetchPokemonData(pokemonId: Int, from networkManager: NetworkManager) {
        let speciesRequest = networkManager.request(PokemonApi.species(pokemonId: pokemonId), responseType: PokemonSpecies.self)
        let typeRequest = networkManager.request(PokemonApi.type(pokemonId: pokemonId), responseType: PokemonTypeDetail.self)
        let evolutionRequest = networkManager.request(PokemonApi.evolutionChain(pokemonId: pokemonId), responseType: PokemonEvolutionChain.self)
        
        Publishers.Zip3(speciesRequest, typeRequest, evolutionRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure(let error):
                    // An error occurred in one of the requests.
                    print("API Request Error: \(error)")
                }
            }) { [weak self] (speciesResponse, typeResponse, evolutionResponse) in
                
                self?.pokemonSpeciesModel = PokemonSpeciesModel(pokemonSpecies: speciesResponse)
                self?.pokemonTypeDetailModel = PokemonTypeDetailModel(pokemonTypeDetail: typeResponse)
                let evolutionChainModel = PokemonEvolutionChainModel(pokemonEvolutionChain: evolutionResponse)
                self?.pokemonEvolutionChainModel = evolutionChainModel
                self?.fetchPokemonEvolutionChainList(for: evolutionChainModel, from: networkManager)
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchPokemonEvolutionChainList(for pokeman: PokemonEvolutionChainModel?, from networkManager: NetworkManager) {
        if let species = pokeman?.getAllSpecies() {
            species.forEach { pokeman in
                fetchPokemonEvolutionChainDetail(for: pokeman, from: networkManager)
            }
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.pokemonEvolutionChainItemList = self?.chainDetailList.map {
                    PokemonEvolutionChainItem.init(id: $0.id, name: $0.name, imageUrl: $0.sprites.thumbnail, gradientColors: $0.gradientColors)
                } ?? []
            }
        }
    }
    
    
    func fetchPokemonEvolutionChainDetail(for pokeman: PokemonNameURL, from networkManager: NetworkManager) {
        dispatchGroup.enter()
        
        networkManager.request(PokemonApi.detail(pokemonId: pokeman.name ?? ""), responseType: PokemonDetail.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API Request finished.")
                case .failure(let error):
                    // An error occurred in one of the requests.
                    print("API Request Error: \(error)")
                }
            }) { [weak self] (response) in
                self?.chainDetailList.append(response)
                self?.dispatchGroup.leave()
            }
            .store(in: &networkManager.cancellables)
        
    }
}

struct PokemonSpeciesModel {
    
    private let pokemonSpecies: PokemonSpecies
    
    init(pokemonSpecies: PokemonSpecies) {
        self.pokemonSpecies = pokemonSpecies
    }
    
    func getFlavorText() -> String {
        pokemonSpecies.flavorTextEntries?.filter { $0.language?.name == "en" }.first?.flavorText ?? ""
    }
    
    func getEggGroups() -> [String] {
        pokemonSpecies.eggGroup?.compactMap { $0.name } ?? []
    }
}

struct PokemonTypeDetailModel {
    
    private let pokemonTypeDetail: PokemonTypeDetail
    
    init(pokemonTypeDetail: PokemonTypeDetail) {
        self.pokemonTypeDetail = pokemonTypeDetail
    }
    
    func getPokemenWeakAgainst() -> [String] {
        guard let relation = pokemonTypeDetail.damageRelations else { return [] }
        
        let allDamageTypes = (relation.doubleDamageFrom ?? []) + (relation.halfDamageFrom ?? []) + (relation.doubleDamageTo ?? []) + (relation.halfDamageTo ?? [])
        
        let uniqueDamageTypes = Array(Set(allDamageTypes.compactMap { $0.name }))
        
        return uniqueDamageTypes
    }
}

struct PokemonStatsModel {
    
    struct Stats {
        let id = UUID()
        let name: String
        let percentage: Int
    }
    
    private let pokemonDetail: PokemonDetail
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    func getPokemenStats() -> [PokemonStatsModel.Stats] {
        let statsArray: [Stats] = pokemonDetail.stats.compactMap { stat in
            guard let name = stat.stat?.name else { return nil }
            return Stats(name: name, percentage: stat.baseStat ?? 0)
        }
        
        return statsArray
    }
}

struct PokemonEvolutionChainModel {
    private let pokemonEvolutionChain: PokemonEvolutionChain
    
    init(pokemonEvolutionChain: PokemonEvolutionChain) {
        self.pokemonEvolutionChain = pokemonEvolutionChain
        
        
    }
    
    func getAllSpecies() -> [PokemonNameURL] {
        var allSpecies: [PokemonNameURL] = []
        
        guard let chain = self.pokemonEvolutionChain.chain,
              let firstSpecies = chain.species else { return allSpecies }
        allSpecies.append(firstSpecies)
        
        guard let secondChain = chain.evolvesTo?.first,
              let secondSpecies = secondChain.species else { return allSpecies }
        allSpecies.append(secondSpecies)
        
        guard let thirdChain = secondChain.evolvesTo?.first,
              let thirdSpecies = thirdChain.species else { return allSpecies }
        allSpecies.append(thirdSpecies)
        
        return allSpecies
    }
}

struct PokemonEvolutionChainItem: Hashable, Identifiable {
    var id: Int
    var name: String?
    var imageUrl: String?
    var gradientColors: [Color]
}
 
