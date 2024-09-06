//
//  FeedbackView.swift
//  Interview
//
//  Created by Rafael Ramos on 06/09/24.
//

import Foundation
import UIKit

final class FeedbackView: UIView {
    private lazy var stackViewContainer: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        return activityIndicator
    }()
    
    private lazy var titleName: UILabel = createLabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        titleName.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func dismiss() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
    
    func showMessage(_ message: String) {
        activityIndicator.isHidden = true
        titleName.isHidden = false
        titleName.text = message
    }
}

extension FeedbackView: ViewCode {
    func addSubViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(activityIndicator)
        stackViewContainer.addArrangedSubview(titleName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
}
