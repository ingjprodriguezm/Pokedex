//
//  PictureService.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

class PictureService
{
    func fetchPicturePokemon(pokeIndex: Int, completion: @escaping (Data?) -> Void)
    {
        let trackURL = URL(string: ApiConstants.basePokemonImage + "\(pokeIndex).png")!
        
        AF.request(trackURL).responseJSON { response in
            guard let data = response.data else { return }
            completion(data)
        }
    }
}

