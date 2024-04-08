//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    @Published var pokemonSpeciesModel: PokemonSpeciesViewModel?
    @Published var pokemonTypeDetailModel: PokemonTypeDetailViewModel?
    @Published var pokemonEvolutionChainModel: PokemonEvolutionChainViewModel?
    @Published var pokemonEvolutionChainItemList: [PokemonEvolutionChainItem]?
    @Published var alertModel: AlertModel = AlertModel(title: "", message: "", isShowing: false)
    @Binding var selectedPokemonId: Int

    
    private let dispatchGroup = DispatchGroup()
    private var chainDetailList: [PokemonDetail] = []
    
    private let pokemonDetailService: PokemonDetailService
    private var allPokemonDetails: [PokemonItem: PokemonDetail] = [:]
    
    var fullFlavorTexts = ""
    var selectedPokemon: PokemonDetail
    
    init(pokemonDetailService: PokemonDetailService,
         selectedPokemonId: Binding<Int>,
         selectedPokemon: PokemonDetail,
         allPokemonDetails: [PokemonItem: PokemonDetail]) {
        self.pokemonDetailService = pokemonDetailService
        self._selectedPokemonId = selectedPokemonId
        self.selectedPokemon = selectedPokemon
        self.allPokemonDetails = allPokemonDetails
        Task {
            await fetchPokemonData(pokemonId: selectedPokemonId.wrappedValue)
        }
    }
    
    func getPokemon(for id: Int) -> (item: PokemonItem?, detail: PokemonDetail?) {
        if let item = allPokemonDetails.first(where: { $0.key.url.getId() == id }) {
            return (item.key, item.value)
        }
        return (nil, nil)
    }
    
    func getPokemonDetail(for id: Int) -> PokemonDetail? {
        allPokemonDetails.first(where: { $0.key.url.getId() == id })?.value
    }
    
    func fetchPokemonData(pokemonId: Int) async {
        await fetchPokemonSpecies(pokemonId: pokemonId)
        await fetchPokemonTypeDetail(pokemonId: pokemonId)
        await fetchPokemonEvolutionChain(pokemonId: pokemonId)
    }
    
    func getPokemonBottomNavigation() -> PokemonBottomNavigation {
        let previousPokemon = getPokemonDetail(for: selectedPokemonId - 1)?.name
        let nextPokemon = getPokemonDetail(for: selectedPokemonId + 1)?.name
        let selectedPokemon = getPokemonDetail(for: selectedPokemonId) ?? .empty // it won't be nil anytime
        
        return .init(previousPokemon: previousPokemon, nextPokemon: nextPokemon, selectedPokemon: selectedPokemon)
    }
}

extension PokemonDetailViewModel {
    
    func fetchPokemonSpecies(pokemonId: Int) async {
        await self.pokemonDetailService.fetchPokemonSpecies(pokemonId: pokemonId) { [weak self] response in
            switch response {
            case .success(let speciesModel):
                let speciesViewModel = PokemonSpeciesViewModel(pokemonSpecies: speciesModel)
                self?.pokemonSpeciesModel = speciesViewModel
            case .failure(let error):
                self?.alertModel = .init(title: "PokemonSpecies API Failed.", message: error.localizedDescription, isShowing: true)
            }
        }
    }
    
    func fetchPokemonTypeDetail(pokemonId: Int) async {
        await self.pokemonDetailService.fetchPokemonTypeDetail(pokemonId: pokemonId) { [weak self] response in
            switch response {
            case .success(let typeModel):
                let typeViewModel = PokemonTypeDetailViewModel(pokemonTypeDetail: typeModel)
                self?.pokemonTypeDetailModel = typeViewModel
            case .failure(let error):
                self?.alertModel = .init(title: "PokemonType API Failed.", message: error.localizedDescription, isShowing: true)
            }
        }
    }
    
    func fetchPokemonEvolutionChain(pokemonId: Int) async {
        await self.pokemonDetailService.fetchPokemonEvolutionChain(pokemonId: pokemonId) { [weak self] response in
            switch response {
            case .success(let evolutionChainModel):
                let evolutionChainViewModel = PokemonEvolutionChainViewModel(pokemonEvolutionChain: evolutionChainModel)
                self?.pokemonEvolutionChainModel = evolutionChainViewModel
                self?.fetchPokemonEvolutionChainList(for: evolutionChainViewModel)
                
            case .failure(let error):
                self?.alertModel = .init(title: "PokemonType API Failed.", message: error.localizedDescription, isShowing: true)
            }
        }
    }
    
    func fetchPokemonEvolutionChainList(for pokeman: PokemonEvolutionChainViewModel?) {
        if let species = pokeman?.getAllSpecies() {
            species.forEach { pokeman in
                Task {
                    dispatchGroup.enter()
                    await fetchPokemonEvolutionChainDetail(for: pokeman)
                    
                    dispatchGroup.notify(queue: .main) { [weak self] in
                        self?.pokemonEvolutionChainItemList = self?.chainDetailList.map {
                            PokemonEvolutionChainItem(id: $0.id, name: $0.name, imageUrl: $0.sprites.thumbnail, gradientColors: $0.gradientColors)
                        } ?? []
                    }
                }
            }
        }
    }
    
    func fetchPokemonEvolutionChainDetail(for pokeman: PokemonNameURL) async {
        await self.pokemonDetailService.fetchPokemonDetail(pokemonId: pokeman.name ?? "") { [weak self] response in
            self?.dispatchGroup.leave()
            switch response {
            case .success(let itemDetail):
                self?.chainDetailList.append(itemDetail)
            case .failure(let error):
                self?.alertModel = .init(title: "PokemonEvolutionChain->Detail API Failed.", message: error.localizedDescription, isShowing: true)
            }
        }
    }
}
