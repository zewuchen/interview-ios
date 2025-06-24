//
//  PokemonCellView.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation
import UIKit

enum PokemonCellType {
    case blue
    case yellow
    case red
}

struct PokemonListCellModel {
    let title: String
    let type: PokemonCellType
}

final class PokemonListCellView: UITableViewCell {

   private let mainStackView: UIStackView = {
       let stack = UIStackView(frame: .zero)
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.alignment = .center
       return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configureConstraints()
    }
    
    func setupCell(with model: PokemonListCellModel) {
        setupTitle(name: model.title)
        setupTypeBackgroundColor(model.type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PokemonListCellView {
    func setupTitle(name: String) {
        titleLabel.text = name
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    func setupTypeBackgroundColor(_ type: PokemonCellType) {
        switch type {
        case .blue:
            titleLabel.textColor = .white
            backgroundColor = .blue
        case .yellow:
            backgroundColor = .yellow
        case .red:
            backgroundColor = .red
        }
    }
}

private extension PokemonListCellView {
    func addSubviews() {
        addSubview(mainStackView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
