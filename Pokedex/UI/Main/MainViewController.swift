//
//  MainViewController.swift
//  Pokedex
//
//  Created by Juan Pablo Rodriguez on 6/05/20.
//  Copyright © 2020 Juan Pablo Rodriguez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD


class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    let bag = DisposeBag()
    let model = MainViewModel()
    var isNormalView = true
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.colorHUD(UIColor.black)
        ProgressHUD.colorSpinner(UIColor.white)
        bind()
    }
}

//MARK: Bind
extension MainViewController {
    func bind() {
        model.pokemonsVariable.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "pokemonCell",
                       cellType: PokemonCell.self)) { (_, object, cell) in
                        cell.model = object
        }
        .disposed(by: bag)
        
        model.showLoadingIndicator.asObservable().subscribe(onNext: { (showLoadingIndicator) in
            if showLoadingIndicator {
                ProgressHUD.show()
            } else{
                ProgressHUD.dismiss()
            }
        }).disposed(by: bag)
        
        searchBar.rx.text.asObservable().debounce(.milliseconds(500), scheduler:  MainScheduler.instance)
                   .distinctUntilChanged()
                   .subscribe(onNext: { (searchText) in
                       self.searchText = searchText!
                       self.onSearch()
                   }).disposed(by: bag)
    }
    
}

//MARK: TableView Delegate
extension MainViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if isNormalView{
                if !self.model.isPerformQuery{
                    self.model.getPokemonPage()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > -1 {
            let index = Int(indexPath.row)
            toDetailsView(pokemonData: model.getDataForIndex(index: index))
        }
    }
}


//MARK: Search
extension MainViewController {
    
    func onSearch() {
        model.reset()
        if !searchText.isEmpty {
            isNormalView = false
            self.searchText = searchBar.text!
            model.getSearchedPokemon(keyword: searchText)
        } else {
            isNormalView = true
            searchText = ""
            model.getPokemonPage()
        }
    }
}


//MARK: Navigation
extension MainViewController {
    func toDetailsView(pokemonData: PokemonData){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        
        vc.currentPokemon = pokemonData
        
        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: vc)
        
        self.present(navEditorViewController, animated: true, completion: nil)
    }
}
