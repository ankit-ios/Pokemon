//
//  PokemonType.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

enum PokemonType: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}

extension PokemonType {
    
    ///fetching color from Assets
    var color: Color {
        Color(self.rawValue)
    }
}

enum PokemonStat: String, CaseIterable {
    case hp
    case attack
    case defense
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed
}
