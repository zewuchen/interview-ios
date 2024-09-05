//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let pokemonListView = PokemonListView()

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Depois de pesquisar, acabei relambrando pra que serve loadView,
    // Ela é chamada pra criar view da hierarquia, então ao inves de criar padrão genérica da viewcontroller estou acionando PokemonListView
    override func loadView() {
        self.view = pokemonListView
    }
}
