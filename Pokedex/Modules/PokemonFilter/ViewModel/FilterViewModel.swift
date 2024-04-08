//
//  FilterViewModel.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    
    @Binding var filterModel: FilterModel
    
    @Published var isTypeExpanded = false
    @Published var isGenderExpanded = false
    @Published var typeCheckedItems: [String: Bool] = [:]
    @Published var genderCheckedItems: [String: Bool] = [:]
    
    private let filterData: [AccordianModel] = [
        .init(title: "Type", items: PokemonType.allCases.map { $0.rawValue }),
        .init(title: "Gender", items: PokemonGender.allCases.map { $0.rawValue })
    ]
    
    init(filterModel: Binding<FilterModel>) {
        self._filterModel = filterModel
    }
    
    func updateUIWithSelectedFilter() {
        filterModel.selectedTypes.forEach { selectedType in
            typeCheckedItems[selectedType] = true
        }
        filterModel.selectedGenders.forEach { selectedGender in
            genderCheckedItems[selectedGender] = true
        }
    }
    
    func getTypeData() -> AccordianModel {
        filterData[0]
    }
    
    func getGenderData() -> AccordianModel {
        filterData[1]
    }
    
    func resetButtonTapped() {
        filterModel.applyFilter = false
        filterModel.selectedTypes = []
        filterModel.selectedGenders = []
    }
    
    func applyButtonTapped() {
        filterModel.applyFilter = true
        filterModel.selectedTypes = typeCheckedItems.filter { $0.value }.map { $0.key }
        filterModel.selectedGenders = genderCheckedItems.filter { $0.value }.map { $0.key }
    }
}
