//
//  DetailView.swift
//  Interview
//
//  Created by Natali Cabral on 23/08/24.
//

import Foundation
import UIKit

public class DetailsView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pokemonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pokemonNome: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let pokemonId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let pokemonPeso: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let pokemonAltura: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    var pokemonNomeValue: String? {
        didSet {
            pokemonNome.text = "Nome: \(pokemonNomeValue ?? "")"
        }
    }
    
    var pokemonIdValue: String? {
        didSet {
            pokemonId.text = "Número: \(pokemonIdValue ?? "")"
        }
    }
    
    var pokemonAlturaValue: String? {
        didSet {
            pokemonAltura.text = "Altura: \(pokemonAlturaValue ?? "")"
        }
    }
    
    var pokemonPesoValue: String? {
        didSet {
            pokemonPeso.text = "Peso: \(pokemonPesoValue ?? "")"
        }
    }
    
    var pokemonDetail: PokemonDetail? {
        didSet {
            guard let pokemonDetail = pokemonDetail else {
                return
            }
            pokemonNomeValue = pokemonDetail.name.capitalized
            pokemonIdValue = pokemonDetail.id.description
            pokemonAlturaValue = pokemonDetail.height.description
            pokemonPesoValue = pokemonDetail.weight.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(pokemonStackView)
        
        [pokemonNome, pokemonId, pokemonAltura, pokemonPeso].forEach { pokemonStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pokemonStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            pokemonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pokemonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setup(image: PokemonsImage) {
        let finalFrame = imageView.frame
        let initialFrame = CGRect.zero
        imageView.frame = initialFrame
        imageView.image = UIImage(named: image.rawValue)
        UIView.animate(withDuration: 0.4) {
            self.imageView.frame = finalFrame
        }
        setupAccessibility()
    }
    
    func setupAccessibility() {
        guard let nome = pokemonDetail?.name else { return }
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "\(nome)"
        imageView.accessibilityTraits = .button
        accessibilityElements = [imageView]
    }
}
