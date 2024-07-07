//
//  DetailViewCell.swift
//  Interview
//
//  Created by Kaled Jamal El Azanki on 03/07/24.
//

import Foundation
import UIKit

private struct MarginValues {
    static let margin10: CGFloat = 10
    static let margin20: CGFloat = 20
    static let margin100: CGFloat = 100
}
public class DetailView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pokemonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = MarginValues.margin10
        return stackView
    }()
    
    private var pokemonNome: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var pokemonNumero: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var pokemonPeso: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private var pokemonAltura: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    var pokemonNomeValue: String? {
        didSet {
            pokemonNome.text = "Nome: \(String(describing: pokemonNomeValue ?? ""))"
        }
    }

    var pokemonNumeroValue: String? {
        didSet {
            pokemonNumero.text = "Numero: \(String(describing: pokemonNumeroValue ?? "" ))"
        }
    }

    var pokemonAlturaValue: String? {
        didSet {
            pokemonAltura.text = "Altura: \(String(describing: pokemonAlturaValue ?? ""))"
        }
    }
    
    var pokemonPesoValue: String? {
        didSet {
            pokemonPeso.text = "Peso: \(String(describing: pokemonPesoValue ?? ""))"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
    
    func setupConstraints(in superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    private func setupView() {
        addSubview(imageView)
        addSubview(pokemonNome)
        addSubview(pokemonNumero)
        addSubview(pokemonAltura)
        addSubview(pokemonPeso)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: MarginValues.margin20),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: MarginValues.margin20),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -MarginValues.margin20),
            imageView.heightAnchor.constraint(equalToConstant: MarginValues.margin100),
            
            pokemonNome.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: MarginValues.margin20),
            pokemonNome.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MarginValues.margin20),
            
            pokemonNumero.topAnchor.constraint(equalTo: pokemonNome.bottomAnchor, constant: MarginValues.margin10),
            pokemonNumero.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MarginValues.margin20),
            
            pokemonAltura.topAnchor.constraint(equalTo: pokemonNumero.bottomAnchor, constant: MarginValues.margin10),
            pokemonAltura.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MarginValues.margin20),
            
            pokemonPeso.topAnchor.constraint(equalTo: pokemonAltura.bottomAnchor, constant: MarginValues.margin10),
            pokemonPeso.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MarginValues.margin20),
        ])
    }

    func setup(image: PokemonsImage) {
        backgroundColor = .white
        let image = UIImage(named: image.rawValue)
        imageView.image = image
        imageView.accessibilityLabel = "O pokemon é \(String(describing: pokemonNomeValue ?? ""))"
        imageView.isAccessibilityElement = true

    }
}
