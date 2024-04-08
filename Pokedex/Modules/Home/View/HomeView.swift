//
//  HomeView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 19/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isFilterSheetPresented = false // To control the filter sheet
    @State private var isPokemonDetailPresented = false // To control the filter sheet
    
    @State private var scrolledToBottom = false
    @State private var selectedPokemonId = -1
    
    @StateObject var viewModel: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init(pokemonListService: PokemonListServiceManager(.shared)))
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                // Pokeman list
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        Text(AppScreenTitles.home)
                            .font(AppFont.navigationTitle)
                            .foregroundColor(AppColors.Text.primary)
                        
                        // divider
                        Divider()
                            .frame(height: 1)
                            .background(.gray)
                        
                        // top label
                        Text(HomeScreenLabels.searchLabel)
                            .font(AppFont.caption)
                            .foregroundColor(AppColors.Text.secondary)
                        
                        // Header
                        SearchFilterHeaderView(searchQuery: $viewModel.searchQuery) {
                            viewModel.performSearch()
                        } filterAction: {
                            isFilterSheetPresented = true
                        }
                        .padding(.all, 6)
                    }
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) { // Set spacing here
                        ForEach(viewModel.filteredPokemons, id: \.name) { item in
                            let pokemonItem = viewModel.getPokemonDetail(for: item)
                            PokemonItemView(pokemon: pokemonItem)
                                .frame(height: 200)
                                .padding(.horizontal, 6)
                                .id(item.name)
                                .onAppear { handlePagignation(item) }
                                .onTapGesture {
                                    selectedPokemonId = pokemonItem?.id ?? -1
                                }
                        }
                    }
                    .padding()
                }
                .padding()
                .overlay(alignment: .bottom, content: {
                    LoadingView(show: $viewModel.isFetchingData)
                })
                
                .onChange(of: selectedPokemonId) { newValue in
                    if newValue != -1 {
                        isPokemonDetailPresented = true
                    }
                }
                .background(AppColors.Background.primary)
                
                // Detail screen
                .fullScreenCover(isPresented: $isPokemonDetailPresented) {
                    let p = viewModel.getPokemon(for: selectedPokemonId)
                    if let detail = p.detail {
                        let vm = PokemonDetailViewModel(
                            pokemonDetailService: PokemonDetailServiceManager(.shared),
                            selectedPokemonId: $selectedPokemonId,
                            selectedPokemon: detail,
                            allPokemonDetails: viewModel.pokemonsDetails)
                        PokemonDetailView(vm: vm, isPokemonDetailPresented: $isPokemonDetailPresented)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchPokemonList()
                }
            }
            
            // Filter popup
            if isFilterSheetPresented {
                GeometryReader { geometry in
                    FilterView(isFilterSheetPresented: $isFilterSheetPresented, filterModel: $viewModel.filterModel)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .background(Color.black.opacity(0.7).edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    private func handlePagignation(_ item: PokemonItem) {
        Task {
            await viewModel.fetchPokemonItemDetail(item)
            
            // pagignation logic
            if viewModel.hasReachedEnd(of: item) {
                await viewModel.fetchNextPagePokemonList()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
