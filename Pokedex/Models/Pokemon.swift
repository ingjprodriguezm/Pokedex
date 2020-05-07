//
//  Pokemon.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation

struct Pokedex: Codable
{
    let count: Int
    let next: String
    let previous: String? 
    let results: [Header]
    
}

struct Header: Codable
{
    let name: String
    let url: String
}

struct Pokemon: Codable
{
    let abilities: [PokeAbility]
    let base_experience: Int
    let forms: [Header]
    let game_indices: [GameIndex]
    let height: Int
    let held_items: [PokeHeld]?
    let id: Int
    let is_default: Bool
    let location_area_encounters: String
    let moves: [PokeMove]
    let name: String
    let order: Int
    let species: Header
    let sprites: Sprites
    let stats: [PokeStat]
    let types: [PokeType]
    let weight: Int
    
}

struct PokeAbility: Codable
{
    let ability: Header
    let is_hidden: Bool
    let slot: Int
}

struct GameIndex: Codable
{
    let game_index: Int
    let version: Header
}

struct PokeHeld: Codable
{
    let item: Header
    let version_details: [PokeVersionDetail]
}

struct PokeVersionDetail: Codable
{
    let rarity: Int
    let version: Header
}

struct PokeMove: Codable
{
    let move: Header
    let version_group_details: [PokeMoveLern]
}

struct PokeMoveLern: Codable
{
    let level_learned_at: Int
    let move_learn_method: Header
    let version_group: Header
}

struct Sprites: Codable
{
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct PokeStat: Codable
{
    let base_stat: Int
    let effort: Int
    let stat: Header
}

struct PokeType: Codable
{
    let slot: Int
    let type: Header
}
