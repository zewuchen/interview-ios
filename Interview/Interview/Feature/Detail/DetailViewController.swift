//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: Variables
    var viewModel: DetailViewModelProtocol
    
    // MARK: UI
    private let pokemonDetailView = PokemonDetailView()
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
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
        bindViewModel()
        viewModel.fetchPokemonDetail()
        setupAccessibility()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.coordinator?.onFinish()
    }
    
    private func bindViewModel() {
        viewModel.onPokemonUpdated = { [weak self] model in
            self?.pokemonDetailView.configure(with: model)
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
