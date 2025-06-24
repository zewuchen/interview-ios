//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController, ErrorHandling, Loadable {
    
    // MARK: Variables
    var viewModel: DetailViewModelProtocol
    var loadingManager: LoadingManaging
    
    // MARK: UI
    private let pokemonDetailView = PokemonDetailView()
    
    init(viewModel: DetailViewModelProtocol, loadingManager: LoadingManaging = LoadingManager()) {
        self.viewModel = viewModel
        self.loadingManager = loadingManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = pokemonDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.coordinator?.onFinish()
    }
    
    func setupLoad() {
        bindViewModel()
        showLoading()
        viewModel.fetchPokemonDetail()

        setupAccessibility()
    }
    
    private func bindViewModel() {
        viewModel.onPokemonUpdated = { [weak self] model in
            DispatchQueue.main.async {
                self?.hideLoading {
                    self?.pokemonDetailView.configure(with: model)
                }
            }
        }
        
        viewModel.onError = { [weak self] error in
            self?.hideLoading {
                self?.showError(error)
            }
        }
    }
    
    private func setupAccessibility() {
        navigationItem.leftBarButtonItem?.accessibilityLabel = "Voltar para a lista de Pokémon"
        navigationItem.leftBarButtonItem?.accessibilityHint = "Toque duas vezes para fechar a tela de detalhes e retornar à lista de Pokémon"
        
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
        
    @objc private func backButtonTapped() {
        let announcement = "Fechando detalhes do Pokémon. Voltando para a sua jornada na Pokédex!"
        UIAccessibility.post(notification: .announcement, argument: announcement)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
