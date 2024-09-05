//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

final class MainViewController: UIViewController, ErrorHandling, Loadable {
    
    // MARK: Variables
    var viewModel: MainViewModelProtocol
    var loadingManager: LoadingManaging
    
    // MARK: UI
    private let pokemonListView = PokemonListView()
    
    init(viewModel: MainViewModelProtocol, loadingManager: LoadingManaging = LoadingManager()) {
        self.viewModel = viewModel
        self.loadingManager = loadingManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLoad()
    }
    
    // Depois de pesquisar, acabei relambrando pra que serve loadView,
    // Ela é chamada pra criar view da hierarquia, então ao inves de criar padrão genérica da viewcontroller estou acionando PokemonListView
    override func loadView() {
        self.view = pokemonListView
    }
    
    func setupLoad() {
        bindViewModel()
        bindPokemonListView()
        
        showLoading()
        viewModel.fetchAllPokemons()
    }
    
    private func bindViewModel() {
        viewModel.onPokemonsUpdated = { [weak self] model in
            DispatchQueue.main.async {
                self?.hideLoading {
                    self?.updateTableView(with: model)
                }
            }
        }
        
        viewModel.onError = { [weak self] error in
            self?.hideLoading {
                self?.showError(error)
            }
        }
    }
    
    private func bindPokemonListView() {
        pokemonListView.onPokemonSelected = { [weak self] index in
            self?.viewModel.didSelectPokemon(at: index)
        }
    }
    
    private func updateTableView(with pokemons: [PokemonListCellModel]) {
        pokemonListView.configure(with: pokemons)
    }
}
