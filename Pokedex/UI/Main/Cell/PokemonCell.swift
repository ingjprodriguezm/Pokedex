//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var primaryTypeImageView: UIImageView!
    @IBOutlet private weak var secondTypeImageView: UIImageView!
    
    var model: PokemonData! {
        didSet {
            setUp()
        }
    }
    
    func setUp() {
        pokemonImageView.image = nil
        primaryTypeImageView.image = nil
        secondTypeImageView.image = nil
        
        nameLabel.text = model.0.name.capitalized
        numberLabel.text = "#\(String(format: "%03d", model.0.id))"
        if let data = model.1 {
            pokemonImageView.image = UIImage(data: data)
        }
        model.0.types.forEach { (pokeType) in
            let slot = pokeType.slot
            if let type = PokemonType(rawValue: pokeType.type.name) {
                asignTypes(type: type,  slot: slot)
            }
        }
        
    }
    
    func asignTypes(type: PokemonType, slot: Int) {
        var image: UIImage? = nil
        switch type {
        case .normal:
            image = UIImage(named: "Types-Normal")!
        case .fighting:
            image = UIImage(named: "Types-Fight")!
        case .flying:
            image = UIImage(named: "Types-Flying")!
        case .poison:
            image = UIImage(named: "Types-Poison")!
        case .ground:
            image = UIImage(named: "Types-Ground")!
        case .rock:
            image = UIImage(named: "Types-Rock")!
        case .bug:
            image = UIImage(named: "Types-Bug")!
        case .ghost:
            image = UIImage(named: "Types-Ghost")!
        case .steel:
            image = UIImage(named: "Types-Steel")!
        case .fire:
            image = UIImage(named: "Types-Fire")!
        case .water:
            image = UIImage(named: "Types-Water")!
        case .grass:
            image = UIImage(named: "Types-Grass")!
        case .electric:
            image = UIImage(named: "Types-Electric")!
        case .psychic:
            image = UIImage(named: "Types-Psychic")!
        case .ice:
            image = UIImage(named: "Types-Ice")!
        case .dragon:
            image = UIImage(named: "Types-Dragon")!
        case .dark:
            image = UIImage(named: "Types-Dark")!
        case .fairy:
            image = UIImage(named: "Types-Fairy")!
        case .unknown:
            image = UIImage(named: "Types-Normal")!
        case .shadow:
            image = UIImage(named: "Types-Shadow")!
        }
        switch slot {
        case 1:
            primaryTypeImageView.image = image
            
        case 2:
            secondTypeImageView.image = image
            
        default:
            break
        }
        
    }
}
