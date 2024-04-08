//
//  PokemanEvolutionChainViewModelTests.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest
@testable import Pokedex

class PokemanEvolutionChainViewModelTests: XCTestCase {

    var viewModel: PokemanEvolutionChainViewModel!
    let testPokemonDetail: PokemonDetail = .dummy

    override func setUp() {
        super.setUp()
        viewModel = PokemanEvolutionChainViewModel(pokemonDetail: testPokemonDetail)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_get_previous_pokeman_id_nil() {
        XCTAssertNil(self.viewModel.getPreviousPokemanId())
    }

    func test_get_previous_pokeman_id() {
        viewModel = .init(pokemonDetail: .init(id: 10, name: "", height: 100, weight: 200,
                                               sprites: .dummy, types: [], abilities: [], stats: []))
        XCTAssertEqual(self.viewModel.getPreviousPokemanId(), 9)
    }

    func test_get_next_pokeman_id() {
        XCTAssertEqual(self.viewModel.getNextPokemanId(), 2)
    }
}
