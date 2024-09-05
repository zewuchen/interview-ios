//
//  View+ViewCode.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol ViewCode {
    func setupView()
    func addSubViews()
    func setupConstraints()
}

extension ViewCode {
    func setupView() {
        addSubViews()
        setupConstraints()
    }
}
