//
//  FilterModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import SwiftUI

class FilterModel: ObservableObject {
    @Published var applyFilter: Bool = false
    @Published var selectedTypes: [String] = []
    @Published var selectedGenders: [String] = []
}
