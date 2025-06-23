//
//  PokemonInfoView.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

final class PokemonInfoView: UIView {
    private lazy var stackViewContainer: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var labelName: UILabel = createLabel()
    private lazy var labelNumber: UILabel = createLabel()
    private lazy var labelHeight: UILabel = createLabel()
    private lazy var labelWeight: UILabel = createLabel()
    
    func fill(detail: PokemonDetailRow) {
        self.labelName.text = detail.name
        self.labelNumber.text = detail.id
        self.labelHeight.text = detail.height
        self.labelWeight.text = detail.weigh
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonInfoView: ViewCode {
    func addSubViews() {
        self.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(labelName)
        stackViewContainer.addArrangedSubview(labelNumber)
        stackViewContainer.addArrangedSubview(labelHeight)
        stackViewContainer.addArrangedSubview(labelWeight)
        
        labelName.accessibilityIdentifier = "label-detail-name"
        labelNumber.accessibilityIdentifier = "label-detail-number"
        labelHeight.accessibilityIdentifier = "label-detail-height"
        labelWeight.accessibilityIdentifier = "label-detail-weight"
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }
}
