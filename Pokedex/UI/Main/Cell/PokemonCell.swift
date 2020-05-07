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

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var secondTypeImageView: UIImageView!
    
    var model: PokemonData!{
        didSet{
            setUp()
        }
    }
    
    func setUp()
    {
        nameLabel.text = model.0.name.capitalized
        numberLabel.text = "#\(String(format: "%03d", model.0.id))"
        if let data = model.1{
            pokemonImageView.image = UIImage(data: data)
        }
        model.0.types.forEach { (pokeType) in
            let type = pokeType.type.name
            let slot = pokeType.slot
            asignTypes(type: type, slot: slot)
        }
        
    }
    
    func asignTypes(type: String, slot: Int)
    {
        var image: UIImage? = nil
        switch type {
        case "normal":
            image = UIImage(named: "Types-Normal")!
            break
        case "fighting":
            image = UIImage(named: "Types-Fight")!
            break
        case "flying":
            image = UIImage(named: "Types-Flying")!
            break
        case "poison":
            image = UIImage(named: "Types-Poison")!
            break
        case "ground":
            image = UIImage(named: "Types-Ground")!
            break
        case "rock":
            image = UIImage(named: "Types-Rock")!
            break
        case "bug":
            image = UIImage(named: "Types-Bug")!
            break
        case "ghost":
            image = UIImage(named: "Types-Ghost")!
            break
        case "steel":
            image = UIImage(named: "Types-Steel")!
            break
        case "fire":
            image = UIImage(named: "Types-Fire")!
            break
        case "water":
            image = UIImage(named: "Types-Water")!
            break
        case "grass":
            image = UIImage(named: "Types-Grass")!
            break
        case "electric":
            image = UIImage(named: "Types-Electric")!
            break
        case "psychic":
            image = UIImage(named: "Types-Psychic")!
            break
        case "ice":
            image = UIImage(named: "Types-Ice")!
            break
        case "dragon":
            image = UIImage(named: "Types-Dragon")!
            break
        case "dark":
            image = UIImage(named: "Types-Dark")!
            break
        case "fairy":
            image = UIImage(named: "Types-Fairy")!
            break
        case "unknown":
            image = UIImage(named: "Types-Normal")!
            break
        case "shadow":
            image = UIImage(named: "Types-Shadow")!
            break
        default:
            break
        }
        switch slot {
        case 1:
            primaryTypeImageView.image = image
            break
        case 2:
            secondTypeImageView.image = image
            break
        default:
            break
        }
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
