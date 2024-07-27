//
//  MainView.swift
//  Interview
//
//  Created by Caio Cesar de Oliveira on 21/07/24.
//

import Foundation
import UIKit

protocol MainTableViewDelegate {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showError()
    func hideError()
}

class MainTableView: UIView, MainTableViewDelegate {

    public let tableView = UITableView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let errorView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupTableView()
        setupLoadingView()
        setupErrorView()
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
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
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

    private func setupErrorView() {
        errorView.text = "Ocorreu um erro ao carregar os dados."
        errorView.textAlignment = .center
        errorView.isHidden = true
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
