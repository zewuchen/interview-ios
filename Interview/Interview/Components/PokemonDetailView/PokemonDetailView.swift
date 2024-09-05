//
//  PokemonDetailView.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation
import UIKit

struct PokemonDetailViewModel {
    let name: String
    let number: String
    let height: String
    let weight: String
    let image: UIImage
}

final class PokemonDetailView: UIView {
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        return stack
     }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var nameLabel = UILabel()
    private lazy var numberLabel = UILabel()
    private lazy var heightLabel = UILabel()
    private lazy var weightLabel = UILabel()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        addSubviews()
        configureConstraints()
    }
    
    func configure(with model: PokemonDetailViewModel) {
        DispatchQueue.main.async {
            self.imageView.image = model.image
            self.nameLabel.text = "Nome: \(model.name.capitalized)"
            self.numberLabel.text = "Número: \(model.number)"
            self.heightLabel.text = "Altura: \(model.height)"
            self.weightLabel.text = "Peso: \(model.weight)"
            
            self.imageView.accessibilityLabel = model.name
            self.imageView.accessibilityTraits = .button
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonDetailView {
    func addSubviews() {
        addSubview(imageView)
        addSubview(contentStackView)
        
        [nameLabel, numberLabel, heightLabel, weightLabel].forEach { label in
            contentStackView.addArrangedSubview(label)
        }
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
