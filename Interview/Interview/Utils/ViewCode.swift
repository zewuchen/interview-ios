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
    func setupAdditional()
}

extension ViewCode {
    func setupView() {
        addSubViews()
        setupConstraints()
        setupAdditional()
    }
    
    func setupAdditional() {}
}
