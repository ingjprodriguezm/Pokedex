//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 8/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class DetailViewController: UIViewController {

    @IBOutlet private weak var detailView: UIView!
    @IBOutlet private weak var conteinerView: UIView!
    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var namePokemonLabel: UILabel!
    @IBOutlet private weak var typeImageView: UIImageView!
    @IBOutlet private weak var typeSecondImageView: UIImageView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var containerViewTopConstrain: NSLayoutConstraint!
    @IBOutlet private weak var imagePokemonTopConstrain: NSLayoutConstraint!
    @IBOutlet private weak var nameLabelTopConstrain: NSLayoutConstraint!
    
    var currentPokemon: PokemonData?
    var currentPokeSpecies: PokemonSpecies? {
        didSet {
            setUp()
        }
    }
    
    func setUp()
    {
        namePokemonLabel.text = ""
        descriptionTextView.text = ""
        
        if let model = currentPokemon {
            namePokemonLabel.text = model.0.name.capitalized
            model.0.types.forEach { (pokeType) in
                let slot = pokeType.slot
                if let type = PokemonType(rawValue: pokeType.type.name) {
                    asignTypes(type: type,  slot: slot)
                }
            }
            if let data = model.1{
                pokemonImageView.image = UIImage(data: data)
            }
        }
        
        if let modeldetail = currentPokeSpecies {
            modeldetail.flavor_text_entries.forEach { (flavor) in
                if flavor.language.name == "es" {
                    descriptionTextView.text = flavor.flavor_text
                }
            }
//            if let backgroundColor = PokemonColor(rawValue: modeldetail.color.name) {
//                asignColor(color: backgroundColor)
//            }
            
        }
        
    }

    let bag = DisposeBag()
    let model = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewTopConstrain.constant = self.view.frame.height * 0.15
        imagePokemonTopConstrain.constant = self.view.frame.height * 0.08
        nameLabelTopConstrain.constant = self.view.frame.height * 0.10 + 10
        ProgressHUD.colorHUD(UIColor.black)
        ProgressHUD.colorSpinner(UIColor.white)
        conteinerView.roundCorners([.topLeft, .topRight], radius: 60.0)
        typeImageView.image = nil
        typeSecondImageView.image = nil
        bind()
    }
    
}


//MARK: Bind
extension DetailViewController {
    func bind() {
        model.pokeSpeciesVariable.asObservable().subscribe(onNext: { (pokeSpeciesVariable) in
            if let currentPokeSpecies = pokeSpeciesVariable.first {
                self.currentPokeSpecies = currentPokeSpecies
            }
        }).disposed(by: bag)
        
        model.showLoadingIndicator.asObservable().subscribe(onNext: { (showLoadingIndicator) in
            if showLoadingIndicator {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }).disposed(by: bag)
        
        if let urlSpecies = currentPokemon?.0.species.url {
            model.getPokemonSpecies(urlPokemon: urlSpecies)
        }
        
    }
        
    
    func asignColor(color: PokemonColor) {
        var iColor: UIColor
        
        switch color {
        case .black:
            iColor = UIColor.black
        case .blue:
            iColor = UIColor.blue
        case .brown:
            iColor = UIColor.brown
        case .gray:
            iColor = UIColor.gray
        case .green:
            iColor = UIColor.green
        case .pink:
            iColor = UIColor(hex: "#EC8CE5")!
        case .purple:
            iColor = UIColor.purple
        case .red:
            iColor = UIColor.red
        case .white:
            iColor = UIColor.white
        case .yellow:
            iColor = UIColor.yellow
        }
        detailView.backgroundColor = iColor
    }
    
    func asignTypes(type: PokemonType, slot: Int) {
        var image: UIImage?
        var iColor: UIColor?
        switch type {
        case .normal:
            image = UIImage(named: "Tag-Normal")!
            iColor = UIColor(hex: "#9298A4")!
        case .fighting:
            image = UIImage(named: "Tag-Fight")!
            iColor = UIColor(hex: "#CE4265")!
        case .flying:
            image = UIImage(named: "Tag-Flying")!
            iColor = UIColor(hex: "#90A7DA")!
        case .poison:
            image = UIImage(named: "Tag-Poison")!
            iColor = UIColor(hex: "#A864C7")!
        case .ground:
            image = UIImage(named: "Tag-Ground")!
            iColor = UIColor(hex: "#DC7545")!
        case .rock:
            image = UIImage(named: "Tag-Rock")!
            iColor = UIColor(hex: "#C5B489")!
        case .bug:
            image = UIImage(named: "Tag-Bug")!
            iColor = UIColor(hex: "#92BC2C")!
        case .ghost:
            image = UIImage(named: "Tag-Ghost")!
            iColor = UIColor(hex: "#516AAC")!
        case .steel:
            image = UIImage(named: "Tag-Steel")!
            iColor = UIColor(hex: "#52869D")!
        case .fire:
            image = UIImage(named: "Tag-Fire")!
            iColor = UIColor(hex: "#FB9B51")!
        case .water:
            image = UIImage(named: "Tag-Water")!
            iColor = UIColor(hex: "#559EDF")!
        case .grass:
            image = UIImage(named: "Tag-Grass")!
            iColor = UIColor(hex: "#5FBC51")!
        case .electric:
            image = UIImage(named: "Tag-Electric")!
            iColor = UIColor(hex: "#EDD53E")!
        case .psychic:
            image = UIImage(named: "Tag-Psychic")!
            iColor = UIColor(hex: "#F66F71")!
        case .ice:
            image = UIImage(named: "Tag-Ice")!
            iColor = UIColor(hex: "#FAFAFA")!
        case .dragon:
            image = UIImage(named: "Tag-Dragon")!
            iColor = UIColor(hex: "#0C69C8")!
        case .dark:
            image = UIImage(named: "Tag-Dark")!
            iColor = UIColor(hex: "#595761")!
        case .fairy:
            image = UIImage(named: "Tag-Fairy")!
            iColor = UIColor(hex: "#EC8CE5")!
        case .unknown:
            image = nil
            iColor = UIColor(hex: "#595761")!
        case .shadow:
            image = UIImage(named: "Tag-Shadow")!
            iColor = UIColor(hex: "#595761")!
        }
        switch slot {
        case 1:
            typeImageView.image = image
            detailView.backgroundColor = iColor
        case 2:
            typeSecondImageView.image = image
        default:
            break
        }
        
    }
}
