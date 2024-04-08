//
//  PokemonEvolutionChainItem.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct PokemonEvolutionChainItem: Hashable, Identifiable {
    var id: Int
    var name: String?
    var imageUrl: String?
    var gradientColors: [Color]
}
