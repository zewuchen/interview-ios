//
//  MainViewCell.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation
import UIKit

private struct MarginValues {
    static let margin16: CGFloat = 16
    static let margin8: CGFloat = 8
}

public class MainViewCell: UITableViewCell {

    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(name)

        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MarginValues.margin16),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MarginValues.margin16),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MarginValues.margin8),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MarginValues.margin8)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
