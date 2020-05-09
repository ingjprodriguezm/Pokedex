//
//  PokeApiService.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

class PokeApiService {
    
    func fetchPokedex(pageManager: PageManager, completion: @escaping (Pokedex?) -> Void) {
        let urlString = "\(pageManager.nextPage)"
        AF.request(urlString, method: .get, headers:["Content-Type": "application/json"]).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let pokedexRequest: Pokedex = try decoder.decode(Pokedex.self, from: data)
                completion(pokedexRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func fetchPokemon(urlPokemon: String, completion: @escaping (Pokemon?) -> Void) {
        let urlString = "\(urlPokemon)"
        AF.request(urlString, method: .get, headers:["Content-Type": "application/json"]).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let pokemonRequest: Pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemonRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func fetchPokemonSearched(keyword: String, completion: @escaping (Pokemon?) -> Void) {
        let urlString = ApiConstants.baseSearchPokemon + "\(keyword.lowercased())/"
        AF.request(urlString, method: .get, headers:["Content-Type": "application/json"]).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let pokemonRequest: Pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemonRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func fetchPokemonSpecies(urlPokemon: String, completion: @escaping (PokemonSpecies?) -> Void) {
        let urlString = "\(urlPokemon)"
        AF.request(urlString, method: .get, headers:["Content-Type": "application/json"]).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let pokemonRequest: PokemonSpecies = try decoder.decode(PokemonSpecies.self, from: data)
                completion(pokemonRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}
