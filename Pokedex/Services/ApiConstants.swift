//
//  ApiConstants.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation

class ApiConstants {
    static let baseURLAPI = "https://pokeapi.co/api/v2/"
    static let basePokemonPage = baseURLAPI + "pokemon?limit=10&offset=0"
    static let basePokemonImage = "https://pokeres.bastionbot.org/images/pokemon/"
    static let baseSearchPokemon = baseURLAPI + "pokemon/"
}
