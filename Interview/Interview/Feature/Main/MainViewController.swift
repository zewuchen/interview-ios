//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Variables
    private var viewModel: MainViewModelProtocol
    
    // MARK: UI
    private let pokemonListView = PokemonListView()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetchAllPokemons()
    }
    
    // Depois de pesquisar, acabei relambrando pra que serve loadView,
    // Ela é chamada pra criar view da hierarquia, então ao inves de criar padrão genérica da viewcontroller estou acionando PokemonListView
    override func loadView() {
        self.view = pokemonListView
    }
    
    private func bindViewModel() {
        viewModel.onPokemonsUpdated = { [weak self] model in
            DispatchQueue.main.async {
                self?.updateTableView(with: model)
            }
        }
    }
    
    private func updateTableView(with pokemons: [PokemonListCellModel]) {
        pokemonListView.configure(with: pokemons)
    }
}
