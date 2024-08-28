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
    private let detailView = DetailsView()
    
    private var url: String
    
    init(url: String, viewModel: DetailViewModelDelegate? = DetailViewModel()) {
        self.url = url
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewControllerDelegate = self
        viewModel?.getPokemonData(url: url)
    }
    
    func setValues(pokemonDetail: PokemonDetail, image: PokemonsImage) {
        DispatchQueue.main.async {
            self.detailView.pokemonDetail = pokemonDetail
            self.detailView.setup(image: image.self)
        }
    }
    
    private func setupMainView() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

public struct PokemonDetail: Decodable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
}

public enum PokemonsImage: String {
    case squirtle
    case bulbasaur
    case charmander
}
