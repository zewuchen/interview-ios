//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showError()
    func hideError()
}

public class MainViewController: UIViewController, MainViewControllerDelegate {

    private let mainTableView = MainTableView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let errorView = UILabel()
    private var viewModel: MainViewModelDelegate?

    init(viewModel: MainViewModelDelegate? = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLoadingView()
        setupErrorView()
        setupDelegates()
        viewModel?.getPokemonData()
        self.navigationItem.title = "Lista de Pokemon"
    }

    private func setupDelegates() {
        viewModel?.viewControllerDelegate = self
        mainTableView.tableView.dataSource = self
        mainTableView.tableView.delegate = self
    }

    private func setupTableView() {
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loadingView.hidesWhenStopped = true
    }

    private func setupErrorView() {
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        errorView.text = "Ocorreu um erro ao carregar os dados."
        errorView.textAlignment = .center
        errorView.isHidden = true
    }

    private func startDetailViewController(url: String) {
        let detailViewController = DetailViewController(url: url)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func reloadData() {
        mainTableView.reloadData()
        hideLoading()
        hideError()
    }

    func showLoading() {
        loadingView.startAnimating()
        mainTableView.isHidden = true
        errorView.isHidden = true
    }

    func hideLoading() {
        loadingView.stopAnimating()
        mainTableView.isHidden = false
    }

    func showError() {
        errorView.isHidden = false
        mainTableView.isHidden = true
        hideLoading()
    }

    func hideError() {
        errorView.isHidden = true
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.countOfPokemons() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? MainViewCell else {
            fatalError("Não pôde encontrar célula PokemonCell!")
        }
        let pokemon = viewModel?.getPokemon(for: indexPath.row)
        let index = indexPath.row + 1
        cell.name.text = "\(index) - \(pokemon?.pokemonName ?? "")"
        cell.backgroundColor = pokemon?.backGround
        cell.name.textColor = pokemon?.textColor
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MainViewCell else { return }
        let pokemon = viewModel?.getPokemon(for: indexPath.row)
        cell.contentView.backgroundColor = pokemon?.backGround
        startDetailViewController(url: pokemon?.url ?? "")
    }

}
