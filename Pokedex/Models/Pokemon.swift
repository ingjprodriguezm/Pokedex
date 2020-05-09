//
//  Pokemon.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
//MARK: Enums

enum PokemonColor: String {
    case black = "black"
    case blue = "blue"
    case brown = "brown"
    case gray = "gray"
    case green = "green"
    case pink = "pink"
    case purple = "purple"
    case red = "red"
    case white = "white"
    case yellow = "yellow"
}

enum PokemonType: String {
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case rock = "rock"
    case bug = "bug"
    case ghost = "ghost"
    case steel = "steel"
    case fire = "fire"
    case water = "water"
    case grass = "grass"
    case electric = "electric"
    case psychic = "psychic"
    case ice = "ice"
    case dragon = "dragon"
    case dark = "dark"
    case fairy = "fairy"
    case unknown = "unknown"
    case shadow = "shadow"
}




//MARK: Pokedex Model
struct Pokedex: Codable {
    let count: Int
    let next: String
    let previous: String? 
    let results: [Header]
    
}

struct Header: Codable {
    let name: String
    let url: String
}

//MARK: Pokemon Model
struct Pokemon: Codable {
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

struct PokeAbility: Codable {
    let ability: Header
    let is_hidden: Bool
    let slot: Int
}

struct GameIndex: Codable {
    let game_index: Int
    let version: Header
}

struct PokeHeld: Codable {
    let item: Header
    let version_details: [PokeVersionDetail]
}

struct PokeVersionDetail: Codable {
    let rarity: Int
    let version: Header
}

struct PokeMove: Codable {
    let move: Header
    let version_group_details: [PokeMoveLern]
}

struct PokeMoveLern: Codable {
    let level_learned_at: Int
    let move_learn_method: Header
    let version_group: Header
}

struct Sprites: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct PokeStat: Codable {
    let base_stat: Int
    let effort: Int
    let stat: Header
}

struct PokeType: Codable {
    let slot: Int
    let type: Header
}

//MARK: Pokemon Species Model
struct PokemonSpecies: Codable {
    let base_happiness: Int
    let capture_rate: Int
    let color: Header
    let egg_groups: [Header]
    let evolution_chain: EvolutionChain
    let flavor_text_entries: [FlavorText]
    let evolves_from_species: Header?
    let form_descriptions: [Header]
    let forms_switchable: Bool
    let gender_rate: Int
    let genera: [Genus]
    let generation: Header
    let growth_rate: Header
    let habitat: Header
    let has_gender_differences: Bool
    let hatch_counter: Int
    let id: Int
    let is_baby: Bool
    let name: String
    let names: [Name]
    let order: Int
    let pal_park_encounters: [Area]
    let pokedex_numbers: [DexNumber]
    let shape: Header
    let varieties: [Variety]
}

struct EvolutionChain: Codable {
    let url: String
}

struct FlavorText: Codable {
    let flavor_text: String
    let language: Header
    let version: Header
}

struct Genus: Codable {
    let genus: String
    let language: Header
}

struct Name: Codable {
    let language: Header
    let name: String
}

struct Area: Codable {
    let area: Header
    let base_score: Int
    let rate: Int
}

struct DexNumber: Codable {
    let entry_number: Int
    let pokedex: Header
}

struct Variety: Codable {
    let is_default: Bool
    let pokemon: Header
}
