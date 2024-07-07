//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation

import UIKit

public class DetailViewController: UIViewController {
    
    private let viewModel = DetailViewModel()
    private let detailView = DetailView()
    private var id: Int

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        viewModel.tableViewUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.setValues()
            }
        }
        viewModel.getPokemonData(id: id)
        self.navigationItem.title = "Detalhes do Pokemon"
        self.navigationItem.leftBarButtonItem?.title = "Voltar"
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "Voltar para a tela anterior e selecionar qual pokemon deseja saber os detalhes"
        self.navigationItem.leftBarButtonItem?.accessibilityHint = "Toque para voltar para a tela anterior"
        self.navigationItem.leftBarButtonItem?.isAccessibilityElement = true

    }

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        view.addSubview(detailView)
        setupMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setValues() {
        let image = viewModel.showPokemonImage(id)
        detailView.pokemonNomeValue = viewModel.pokemonDetails?.name.description
        detailView.pokemonNumeroValue = viewModel.pokemonDetails?.id.description
        detailView.pokemonAlturaValue = viewModel.pokemonDetails?.height.description
        detailView.pokemonPesoValue = viewModel.pokemonDetails?.weight.description
        detailView.setup(image: image.self)
    }

    private func setupMainView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.setupConstraints(in: view)
    }
}
