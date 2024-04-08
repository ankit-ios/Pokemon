//
//  PokemanAbilityView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemanAbilityView: View {
    
    let pokemonDetail: PokemonDetail
    @Binding var pokemonSpecies: PokemonSpeciesViewModel?
    @Binding var pokemonTypeDetail: PokemonTypeDetailViewModel?
    
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(DetailScreenLabels.heightLabel)
                                .font(AppFont.body)
                            Text("\(pokemonDetail.height)").font(AppFont.caption)
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(DetailScreenLabels.genderLabel)
                                .font(AppFont.body)
                            Text("\(PokemonGenderManager.shared.getGenders(for: pokemonDetail.name ?? "").joined(separator: ", "))").font(AppFont.caption)
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(DetailScreenLabels.abilitiesLabel)
                                .font(AppFont.body)
                            let abilitiesArr = pokemonDetail.abilities
                                .compactMap { $0.ability?.name }
                                .joined(separator: ", ")
                            Text("\(abilitiesArr)")
                                .font(AppFont.caption)
                                .lineLimit(2)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(DetailScreenLabels.weightLabel)
                                .font(AppFont.body)
                            Text("\(pokemonDetail.weight)")
                                .font(AppFont.caption)
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(DetailScreenLabels.eggGroupLabel)
                                .font(AppFont.body)
                            Text(pokemonSpecies?.getEggGroups().joined(separator: ", ") ?? "")
                                .font(AppFont.caption)
                        }
                        .padding(.bottom)
                        
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(DetailScreenLabels.typesLabel)
                                .font(AppFont.body)
                            ScrollView(.horizontal, showsIndicators: true) {
                                let types = pokemonDetail.types.compactMap { $0.type?.name }
                                LazyHGrid(rows: [GridItem(.adaptive(minimum: 20))]) {
                                    ForEach(types, id: \.self) { item in
                                        Text(item)
                                            .font(AppFont.caption)
                                            .padding(.init(top: 2, leading: 8, bottom: 2, trailing: 8))
                                            .background((PokemonType(rawValue: item) ?? .normal).color)
                                            .foregroundColor(AppColors.Text.primary)
                                            .cornerRadius(6)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(AppColors.Text.primary, lineWidth: 1)
                                            )
                                    }.padding(.horizontal, 1)
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.bottom)
                    }
                    .frame(width: geometry.size.width * 0.5)
                }
                
                VStack(alignment: .leading) {
                    Text(DetailScreenLabels.weakAgainstLabel)
                        .font(AppFont.body)
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 20))]) {
                            let weekAgainst = pokemonTypeDetail?.getPokemenWeakAgainst() ?? []
                            ForEach(weekAgainst, id: \.self) { item in
                                Text(item)
                                    .font(AppFont.caption)
                                    .padding(.init(top: 2, leading: 8, bottom: 2, trailing: 8))
                                    .background((PokemonType(rawValue: item) ?? .normal).color)
                                    .foregroundColor(AppColors.Text.primary)
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(AppColors.Text.primary, lineWidth: 1)
                                    )
                            }.padding(.horizontal, 1)
                        }
                    }
                    .frame(height: 30)
                }.padding(.horizontal)
            }
        }
    }
}

struct PokemanAbilityView_Previews: PreviewProvider {
    static var previews: some View {
        PokemanAbilityView(pokemonDetail: .dummy, pokemonSpecies: .constant(nil), pokemonTypeDetail: .constant(nil))
    }
}
