//
//  PokemonDetailViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
@testable import Pokedex

class PokemonDetailViewModelTests: XCTestCase {
    var viewModel: PokemonDetailViewModel!

    override func setUp() {
        super.setUp()
        let mockNetworkService = PokemonDetailServiceMockServer()
        viewModel = PokemonDetailViewModel(networkManager: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_fetch_pokemon_all_data() async {
        let expectation = expectation(description: "Fetching Pokemon all Data")
        Task {
            do {
                await self.viewModel.fetchPokemonData(pokemonId: 10)
                try await Task.sleep(for: .seconds(2))
                XCTAssertNotNil(self.viewModel.pokemonSpeciesModel)
                XCTAssertNotNil(self.viewModel.pokemonTypeDetailModel)
                XCTAssertNotNil(self.viewModel.pokemonEvolutionChainModel)
                XCTAssertNotNil(self.viewModel.pokemonEvolutionChainItemList)
                expectation.fulfill()
            } catch {
                XCTFail("Error occurred: \(error)")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 20)
    }

    func test_fetch_pokemon_species() async {
        let expectation = expectation(description: "Fetching Pokemon Species")
        Task {
            do {
                await self.viewModel.fetchPokemonSpecies(pokemonId: 10)
                try await Task.sleep(for: .seconds(2))
                XCTAssertNotNil(self.viewModel.pokemonSpeciesModel)
                expectation.fulfill()
            } catch {
                XCTFail("Error occurred: \(error)")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 20)
    }

    func test_fetch_pokemon_type_detail() async {
        let expectation = expectation(description: "Fetching Pokemon type detail")
        Task {
            do {
                await self.viewModel.fetchPokemonTypeDetail(pokemonId: 10)
                try await Task.sleep(for: .seconds(2))
                XCTAssertNotNil(self.viewModel.pokemonTypeDetailModel)
                expectation.fulfill()
            } catch {
                XCTFail("Error occurred: \(error)")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 20)
    }

    func test_fetch_pokemon_evolution_chain() async {
        let expectation = expectation(description: "Fetching Pokemon Evolution Chain")
        Task {
            do {
                await self.viewModel.fetchPokemonEvolutionChain(pokemonId: 10)
                try await Task.sleep(for: .seconds(2))
                XCTAssertNotNil(self.viewModel.pokemonEvolutionChainModel)
                XCTAssertNotNil(self.viewModel.pokemonEvolutionChainItemList)
                expectation.fulfill()
            } catch {
                XCTFail("Error occurred: \(error)")
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 20)
    }
}
