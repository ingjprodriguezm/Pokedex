//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 8/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    let pokeApiService: PokeApiService
    let pictureService: PictureService
    
    let pokeSpeciesVariable: Variable<[PokemonSpecies]> = Variable([])
    let showLoadingIndicator: Variable<Bool> = Variable(false)
    
    var isPerformQuery = false
    
    init() {
        self.pokeApiService = PokeApiService()
        self.pictureService = PictureService()
    }
}

//MARK: fetch request
extension DetailViewModel {
    
    func getPokemonSpecies(urlPokemon: String) {
        isPerformQuery = true
        showLoadingIndicator.value = true
        pokeApiService.fetchPokemonSpecies(urlPokemon: urlPokemon) {
            pokemonSpecies in
            self.isPerformQuery = false
            self.showLoadingIndicator.value = false
            if let pokemonSpecies = pokemonSpecies {
                self.pokeSpeciesVariable.value.append(pokemonSpecies)
            }
        }
    }
}

//MARK: Utils
extension DetailViewModel {
    
    func reset() {
        pokeSpeciesVariable.value.removeAll()
    }
}

