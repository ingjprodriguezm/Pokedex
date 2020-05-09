//
//  MainViewModel.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
import RxSwift

typealias PokemonData = (Pokemon,Data?)

class MainViewModel {
    
    let pokeApiService: PokeApiService
    let pictureService: PictureService
    let pageManagerPokemon: PageManager
    
    let pokemonsVariable: Variable<[PokemonData]> = Variable([])
    let showLoadingIndicator: Variable<Bool> = Variable(false)
    
    var isPerformQuery = false
    
    init() {
        self.pokeApiService = PokeApiService()
        self.pictureService = PictureService()
        self.pageManagerPokemon = PageManager()
    }
}

//MARK: fetch request
extension MainViewModel {
    func getPokemonPage() {
        isPerformQuery = true
        showLoadingIndicator.value = true
        pokeApiService.fetchPokedex(pageManager: pageManagerPokemon) {
            pokedex in
            self.isPerformQuery = false
            self.showLoadingIndicator.value = false
            if let pokedex = pokedex {
                self.pageManagerPokemon.nextPage(nextPage: pokedex.next)
                self.getImages(pokedex: pokedex)
            }
        }
    }
    
    func getImages(pokedex: Pokedex) {
        
        pokedex.results.forEach { (pokemon) in
            DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
                self.pokeApiService.fetchPokemon(urlPokemon: pokemon.url, completion: { (pokemonDetail) in
                    if let pokemonDetail = pokemonDetail{
                        self.pokemonsVariable.value.append((pokemonDetail,nil))
                        self.pictureService.fetchPicturePokemon(pokeIndex: pokemonDetail.id, completion: { (data) in
                            if let data = data {
                                for i in 0..<self.pokemonsVariable.value.count{
                                    if self.pokemonsVariable.value[i].0.name == pokemonDetail.name{
                                        self.pokemonsVariable.value[i].1 = data
                                    }
                                }
                                self.pokemonsVariable.value = self.pokemonsVariable.value.sorted(by: {$0.0.id < $1.0.id})
                            }
                        })
                    }
                })
            }
        }
    }
    
    func getSearchedPokemon(keyword: String) {
        isPerformQuery = true
        showLoadingIndicator.value = true
        pokeApiService.fetchPokemonSearched(keyword: keyword) { (pokemon) in
            self.isPerformQuery = false
            self.showLoadingIndicator.value = false
            if let pokemon = pokemon {
                self.getImage(pokemon: pokemon)
            }
        }
    }
    
    func getImage(pokemon: Pokemon) {
        let pokemonUrl =  ApiConstants.baseSearchPokemon + "\(pokemon.id)/"
        self.pokemonsVariable.value.append((pokemon,nil))
        DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
            self.pokeApiService.fetchPokemon(urlPokemon: pokemonUrl, completion: { (pokemonDetail) in
                if let pokemonDetail = pokemonDetail{
                    self.pictureService.fetchPicturePokemon(pokeIndex: pokemonDetail.id, completion: { (data) in
                        if let data = data {
                            for i in 0..<self.pokemonsVariable.value.count{
                                if self.pokemonsVariable.value[i].0.name == pokemon.name{
                                    self.pokemonsVariable.value[i].1 = data
                                }
                            }
                        }
                    })
                }
            })
        }
    }
}



//MARK: Information Manager
extension MainViewModel {
    
    func getDataForIndex(index: Int) -> PokemonData {
        return self.pokemonsVariable.value[index]
    }
}


//MARK: Utils
extension MainViewModel {
    
    func reset() {
        pokemonsVariable.value.removeAll()
        pageManagerPokemon.resetPage()
    }
}
