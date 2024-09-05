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
}
