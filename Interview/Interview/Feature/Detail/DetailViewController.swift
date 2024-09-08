//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModelProtocol
    private lazy var feedbackView: FeedbackView = .init()
    private lazy var pokemonInfoView: PokemonInfoView = PokemonInfoView()
    
    private lazy var imageViewPokemon: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "imageview-detail"
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDelegate(self)
        viewModel.fetchDetail()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
    }
}

extension DetailViewController: ViewCode {
    func addSubViews() {
        view.addSubview(imageViewPokemon)
        view.addSubview(pokemonInfoView)
        view.addSubview(feedbackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageViewPokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageViewPokemon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageViewPokemon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageViewPokemon.heightAnchor.constraint(equalToConstant: 244),
            
            pokemonInfoView.topAnchor.constraint(equalTo: imageViewPokemon.bottomAnchor, constant: Constants.Space.medium),
            pokemonInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.Space.medium),
            pokemonInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        feedbackView.attach(at: view)
    }
    
    func setupAdditional() {
        imageViewPokemon.isAccessibilityElement = true
        imageViewPokemon.accessibilityIdentifier = "imageview.detail.pokemon"
        imageViewPokemon.accessibilityTraits = .button
        
        imageViewPokemon.accessibilityTraits.remove(.image)
        imageViewPokemon.accessibilityTraits.insert(.button)
    }
}

extension DetailViewController: DetailViewModelOutput {
    func willLoadPokemonInfo(message: String) {
        DispatchQueue.main.async {
            self.feedbackView.startAnimating()
        }
    }
    
    func loadedPokemonInfoWithSuccess(detail: PokemonDetailRow) {
        DispatchQueue.main.async {
            self.imageViewPokemon.accessibilityLabel = detail.imageViewAccessibilityLabel
            self.pokemonInfoView.fill(detail: detail)
            self.imageViewPokemon.image = .init(named: detail.imageAsset)
            self.feedbackView.dismiss()
        }
    }
    
    func loadedPokemonsInfoFailure(message: String) {
        DispatchQueue.main.async {
            self.feedbackView.showMessage(message)
        }
    }
}
