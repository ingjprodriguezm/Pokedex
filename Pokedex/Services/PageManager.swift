//
//  PageManager.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import Foundation

class PageManager {
    
    var initialPage: String
    var nextPage: String
    var previousPage: String
    
    init() {
        self.initialPage = ApiConstants.basePokemonPage
        self.nextPage = self.initialPage
        self.previousPage = ""
    }
    
    func nextPage(nextPage: String) {
        previousPage = self.nextPage
        self.nextPage = nextPage
    }
    
    func resetPage() {
        nextPage = initialPage
        previousPage = ""
    }
}
