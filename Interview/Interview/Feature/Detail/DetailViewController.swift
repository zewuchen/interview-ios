//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func setValues(pokemonDetail: PokemonDetail, image: PokemonsImage)
}

public class DetailViewController: UIViewController, DetailViewControllerDelegate {

    private var viewModel: DetailViewModelDelegate?
    private let detailView = DetailView()
    private var url: String

    init(url: String, viewModel: DetailViewModelDelegate? = DetailViewModel()) {
        self.url = url
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.addSubview(detailView)
        setupMainView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewControllerDelegate = self
        viewModel?.getPokemonData(url: url)

    }

    func setupNavigation() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.title = "Detalhes do Pokemon"
        self.navigationItem.leftBarButtonItem?.accessibilityLabel = "Voltar para a tela anterior e selecionar qual pokemon deseja saber os detalhes."
        self.navigationItem.leftBarButtonItem?.accessibilityHint = "Toque, para voltar à tela anterior."
        self.navigationItem.leftBarButtonItem?.isAccessibilityElement = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setValues(pokemonDetail: PokemonDetail, image: PokemonsImage) {
        DispatchQueue.main.async {
            self.detailView.pokemonNomeValue = pokemonDetail.name
            self.detailView.pokemonNumeroValue = pokemonDetail.id.description
            self.detailView.pokemonAlturaValue = pokemonDetail.height.description
            self.detailView.pokemonPesoValue = pokemonDetail.weight.description
            self.detailView.setup(image: image.self)
        }
    }

    private func setupMainView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.setupConstraints(in: view)
    }

}
