//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var allPokemons: [PokemonItem] = []
    @Published var filteredPokemons: [PokemonItem] = []
    @Published var pokemonsDetails: [PokemonItem: PokemonDetail] = [:]
    @Published var searchQuery: String = ""
    @Published var isFetchingData: Bool = false
    @Published var isSearchFilterApplied: Bool = false
    @Published var filterModel: FilterModel = .init()
    
    private let pokemonListService: PokemonListService
    private var cancellableSearch: AnyCancellable?
    private var cancellableFilter: AnyCancellable?
    
    init(pokemonListService: PokemonListService) {
        self.pokemonListService = pokemonListService
        setupSearchPublisher()
        setupFilterPublisher()
    }
    
    @MainActor func fetchPokemonList() async {
        isFetchingData = true
        await self.pokemonListService.fetchPokemonList { response in
            switch response {
            case .success(let list):
                self.allPokemons = list.results
                self.performSearch()
                self.isFetchingData = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor func fetchNextPagePokemonList() async {
        guard !isSearchFilterApplied else { return }
        isFetchingData = true
        try? await Task.sleep(for: .seconds(2))
        await self.pokemonListService.fetchNextPagePokemonList { response in
            switch response {
            case .success(let list):
                self.allPokemons.append(contentsOf: list.results)
                self.performSearch()
                self.isFetchingData = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemonItemDetail(_ item: PokemonItem) async {
        guard !pokemonsDetails.contains(where: {$0.key.name == item.name}),
              let id = item.url.getId() else { return }
        
        await self.pokemonListService.fetchPokemonItemDetail(pokemonId: id, item) { response in
            switch response {
            case .success(let itemDetail):
                self.pokemonsDetails[item] = itemDetail
                if let index = self.allPokemons.firstIndex(where: { $0.name == item.name }) {
                    self.allPokemons[index].thumbnail = itemDetail.sprites.thumbnail
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func hasReachedEnd(of item: PokemonItem) -> Bool {
        guard searchQuery.isEmpty else { return false }
        return allPokemons.last?.name == item.name
    }
    
}

// MARK: - Utility methods
extension HomeViewModel {
    
    func getPokemonDetail(for item: PokemonItem) -> PokemonDetail? {
        pokemonsDetails.first(where: { $0.key.name == item.name })?.value
    }
    
    func getPokemon(for id: Int) -> (item: PokemonItem?, detail: PokemonDetail?) {
        if let item = pokemonsDetails.first(where: { $0.key.url.getId() == id }) {
            return (item.key, item.value)
        }
        return (nil, nil)
    }
}

// MARK: - Search and Filter helpers
extension HomeViewModel {
    
    func setupSearchPublisher() {
        cancellableSearch = $searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] _ in
                self?.performSearch()
            })
    }
    
    func setupFilterPublisher() {
        cancellableFilter = filterModel.$applyFilter
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.performFilter()
            })
    }
    
    func performSearch() {
        filteredPokemons = searchQuery.isEmpty ? allPokemons : allPokemons
            .filter { $0.name.lowercased().contains(searchQuery.lowercased()) ||
                "\($0.url.getId() ?? -1)" == searchQuery }
    }
    
    func performFilter() {
        searchQuery = ""
        var fPokemons: [PokemonItem] = []
        
        if filterModel.applyFilter {
            // type filtering
            if !filterModel.selectedTypes.isEmpty {
                fPokemons = allPokemons.filter({ item in
                    if let detail = self.getPokemonDetail(for: item) {
                        return filterModel.selectedTypes.contains { type in
                            detail.types.compactMap { $0.type?.name }.contains(type)
                        }
                    }
                    return false
                })
            }
            // gender filtering
            if !filterModel.selectedGenders.isEmpty {
                fPokemons = allPokemons.filter({ item in
                    return filterModel.selectedGenders.contains { gender in
                        PokemonGenderManager.shared.getGenders(for: item.name).contains(gender)
                    }
                })
            }
        } else {
            fPokemons = allPokemons
        }

        filteredPokemons = fPokemons
    }
}
