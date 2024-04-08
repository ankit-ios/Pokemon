//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPokemonDetailPresented: Bool
    @ObservedObject var viewModel: PokemonDetailViewModel
    @State var isShowFullDetailPresented: Bool = false
    
    init(vm: PokemonDetailViewModel,
         isPokemonDetailPresented: Binding<Bool>) {
        self._viewModel = ObservedObject(wrappedValue: vm)
        self._isPokemonDetailPresented = isPokemonDetailPresented
    }
    
    var body: some View {
        ZStack {
            AppColors.Background.primary
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                let pokemonDetail  = viewModel.selectedPokemon
                
                VStack {
                    // Navigation view
                    NavigationHeaderView(model: NavigationHeaderItem(title: pokemonDetail.name?.uppercased() ?? "", subTitle: String(format: "%03d", pokemonDetail.id), isPresented: presentationMode))
                        .padding(.horizontal)
                    
                    // Heading view
                    PokemonDetailHeadingView(pokemonDetail: pokemonDetail, pokemonSpices: $viewModel.pokemonSpeciesModel) { fullFlavorTexts in
                        self.viewModel.fullFlavorTexts = fullFlavorTexts
                        self.isShowFullDetailPresented = true
                    }
                    .frame(height: 300)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Pokeman Ability view
                    PokemanAbilityView(pokemonDetail: pokemonDetail, pokemonSpecies: $viewModel.pokemonSpeciesModel, pokemonTypeDetail: $viewModel.pokemonTypeDetailModel)
                        .frame(height: 260)
                        .padding()
                    Spacer()
                    
                    // Pokeman State view
                    PokemanStatsView(statsModel: PokemonStatsViewModel(pokemonDetail: pokemonDetail))
                        .frame(minHeight: 200, maxHeight: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    PokemanEvolutionChainView(selectedPokemonId: $viewModel.selectedPokemonId, pokemonNavigation: viewModel.getPokemonBottomNavigation(),
                                              pokemonEvolutionChainItemList: $viewModel.pokemonEvolutionChainItemList)
                    .frame(height: 250)
                    .padding()
                } // Outer VStack
            }
            .background(AppColors.Background.primary)
            .navigationBarHidden(true)
            .padding(.top, 1)
        }

        // Show more sheet
        .sheet(isPresented: $isShowFullDetailPresented) {
            PopupView(isShowingPopup: $isShowFullDetailPresented) {
                Text(viewModel.fullFlavorTexts)
                    .foregroundColor(.white)
                    .font(AppFont.caption)
                    .padding()
            }
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(20)
            .presentationDragIndicator(.hidden)
        }
        
        // Error handling
        .alert(isPresented: $viewModel.alertModel.isShowing) {
            Alert(
                title: Text(viewModel.alertModel.title),
                message: Text(viewModel.alertModel.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(vm:
                .init(pokemonDetailService: PokemonDetailServiceManager(.shared), selectedPokemonId: .constant(1), selectedPokemon: .dummy, allPokemonDetails: [:]),
                          isPokemonDetailPresented: .constant(false))
    }
}
