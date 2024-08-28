//
//  MainViewCell.swift
//  Interview
//
//  Created by Natali Cabral on 25/08/24.
//

import Foundation
import UIKit

private struct MarginValues {
    static let large: CGFloat = 20
    static let small: CGFloat = 10
}

public class MainViewCell: UITableViewCell {
    
     let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MarginValues.large),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MarginValues.large),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MarginValues.small),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MarginValues.small)
        ])
    }
}
