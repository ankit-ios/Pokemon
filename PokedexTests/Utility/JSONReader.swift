//
//  JSONReader.swift
//  PokedexTests
//
//  Created by Ankit Sharma on 30/10/23.
//

import Foundation

final class JSONReader {

    enum File: String {
        case list = "PokemonList"
        case detail = "PokemonDetail"
        case species = "PokemonSpecies"
        case evolution = "PokemonEvolution"
        case typeDetail = "PokemonTypeDetail"
    
        var name: String { rawValue }
        var type: String { "json" }
    }

    static func load(_ file: File) -> Data? {
        guard
            let path = Bundle(for: self).path(forResource: file.name, ofType: file.type),
            let jsonString = try? String(contentsOfFile: path, encoding: .utf8),
            let data = jsonString.data(using: .utf8) else { return nil }
        return data
    }
}
