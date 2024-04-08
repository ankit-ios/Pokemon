//
//  HomeViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
@testable import Pokedex

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        let mockNetworkService = PokemonListServiceMockServer()
        viewModel = HomeViewModel(networkManager: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_search_query() async {
        Task {
            await viewModel.fetchPokemonList()
            try? await Task.sleep(for: .seconds(2))

            // Set a search query
            viewModel.searchQuery = "Pikachu"

            // Ensure that the filteredPokemons array is updated correctly
            XCTAssertEqual(viewModel.filteredPokemons.count, 0)

            // Perform another search
            viewModel.searchQuery = "Bulbasaur"
            XCTAssertEqual(viewModel.filteredPokemons.count, 0)

            // Clear the search query
            viewModel.searchQuery = ""
            XCTAssertEqual(viewModel.filteredPokemons.count, viewModel.allPokemons.count)
        }
    }

    func test_fetch_pokemon_list() async {
        Task {
            await viewModel.fetchPokemonList()
            try? await Task.sleep(for: .seconds(2))
            XCTAssertFalse(self.viewModel.allPokemons.isEmpty)
        }
    }

    func test_fetch_next_pokemon_list() async {
        Task {
            await viewModel.fetchNextPagePokemonList()
            try? await Task.sleep(for: .seconds(2))
            XCTAssertFalse(self.viewModel.allPokemons.isEmpty)
        }
    }

    func test_fetch_pokemon_item_details() async {
        let item = PokemonItem(name: "Pikachu", url: "https://example.com/pikachu")
        Task {
            await viewModel.fetchPokemonItemDetail(item)
            try? await Task.sleep(for: .seconds(2))
            XCTAssertNil(self.viewModel.pokemonsDetails[item])
        }
    }

    func test_get_id() {
        let urlString = "https://example.com/pokemon/25"
        let id = urlString.getId()
        XCTAssertEqual(id, 25)

        let invalidURL = "invalid-url"
        let invalidId = invalidURL.getId()
        XCTAssertNil(invalidId)
    }

    func test_pokemon_list_has_reached_end() async {
        Task {
            await viewModel.fetchPokemonList()
            try? await Task.sleep(for: .seconds(2))
            let item = PokemonItem(name: "raticate", url: "https://pokeapi.co/api/v2/pokemon/20/")
            let flag = viewModel.hasReachedEnd(of: item)
            XCTAssertTrue(flag)
        }
    }

    func test_pokemon_list_has_not_reached_end() async {
        Task {
            await viewModel.fetchPokemonList()
            try? await Task.sleep(for: .seconds(2))
            let item = PokemonItem(name: "caterpie", url: "https://pokeapi.co/api/v2/pokemon/10/")
            let flag = viewModel.hasReachedEnd(of: item)
            XCTAssertFalse(flag)
        }
    }

    func test_pokemon_item_detail() async {
        Task {
            do {
                await viewModel.fetchPokemonList()
                try await Task.sleep(for: .seconds(2))
                let test = PokemonItem(name: "caterpie", url: "https://pokeapi.co/api/v2/pokemon/10/")
                viewModel.pokemonsDetails[test] = getDetailItem(10, name: "caterpie")
                let itemDetail = viewModel.getPokemonDetail(for: test)
                XCTAssertEqual(itemDetail?.id, 10)
                XCTAssertEqual(itemDetail?.name, "caterpie")
            } catch {
                XCTFail("Error occurred: \(error)")
            }
        }
    }

    func test_pokemon_detail_by_id() async {
        Task {
            do {
                await viewModel.fetchPokemonList()
                try await Task.sleep(for: .seconds(2))
                let test = PokemonItem(name: "caterpie", url: "https://pokeapi.co/api/v2/pokemon/10/")
                viewModel.pokemonsDetails[test] = getDetailItem(10, name: "caterpie")
                let (item, details) = viewModel.getPokemon(for: 10)
                XCTAssertEqual(item, test)
                XCTAssertEqual(details?.name, "catherie")
            } catch {
                XCTFail("Error occurred: \(error)")
            }
        }
    }
}

extension HomeViewModelTests {
    func getDetailItem(_ id: Int, name: String) -> PokemonDetail {
        return .init(id: id, name: name, height: 100, weight: 200,
                sprites: .dummy, types: [], abilities: [], stats: [])
    }
}
