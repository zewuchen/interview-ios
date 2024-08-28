//
//  MainView.swift
//  Interview
//
//  Created by Natali Cabral on 25/08/24.
//

import Foundation
import UIKit

protocol MainTableViewDelegate: AnyObject {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showError()
    func hideError()
}

class MainTableView: UIView, MainTableViewDelegate {
    
    public let tableView = UITableView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let errorView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .red
        label.text = "An error occurred"
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupTableView()
        setupLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func setupLoadingView() {
        loadingView.hidesWhenStopped = true
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoading()
            self.hideError()
        }
    }
    
    func showLoading() {
        loadingView.startAnimating()
        tableView.isHidden = true
        errorView.isHidden = true
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
        tableView.isHidden = false
    }
    
    func showError() {
        errorView.isHidden = false
        tableView.isHidden = true
        hideLoading()
    }
    
    func hideError() {
        errorView.isHidden = true
    }
}
