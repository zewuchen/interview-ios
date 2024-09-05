//
//  PokemonTableViewCell.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

final class PokemonTableViewCell: UITableViewCell {
    private lazy var labelTitle: UILabel = createLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(row: PokemonRow) {
        labelTitle.text = row.title
        backgroundColor = row.background
    }
}

extension PokemonTableViewCell: ViewCode {
    func addSubViews() {
        contentView.addSubview(labelTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Space.medium),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label.adaptedTextColor()
        return label
    }
}
