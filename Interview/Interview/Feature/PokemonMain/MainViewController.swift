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
    
     let mainTableView = MainTableView()
    public let loadingView = UIActivityIndicatorView(style: .large)
    public let errorView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .red
        label.text = "An error occurred"
        label.isHidden = true
        return label
    }()
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
        setupView()
        setupConstraints()
        setupDelegates()
        viewModel?.getPokemonData()
    }
    
    private func setupView() {
        view.addSubview(mainTableView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
        listNavigationTitle()
        setupNavigationAccessibility()
    }
    private func listNavigationTitle() {
        self.navigationItem.title = "Lista de Pokémons"
    }
    private func setupNavigationAccessibility() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Lista de Pokémons", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.accessibilityLabel = "Voltar para a Lista de Pokémons"
        navigationItem.backBarButtonItem?.isAccessibilityElement = true
    }
    
    private func setupConstraints() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupDelegates() {
        viewModel?.viewControllerDelegate = self
        mainTableView.tableView.dataSource = self
        mainTableView.tableView.delegate = self
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
        return viewModel?.countOfPokemons() ?? .zero
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? MainViewCell else {
            fatalError("Não foi possível carregar PokemonCell!")
        }
        preparePokemonCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func preparePokemonCell(cell: MainViewCell, indexPath: IndexPath) {
        if let pokemon = viewModel?.getPokemon(for: indexPath.row) {
            let index = indexPath.row + 1
            cell.nameLabel.text = "\(index) - \(pokemon.pokemonName)"
            cell.backgroundColor = pokemon.backGround
            cell.nameLabel.textColor = pokemon.textColor
        } else {
            cell.nameLabel.text = "\(indexPath.row + 1)"
            cell.backgroundColor = .clear
            cell.nameLabel.textColor = .black
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = viewModel?.getPokemon(for: indexPath.row) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        startDetailViewController(url: pokemon.url)
    }
}

public struct PokemonModel: Decodable {
    var results: [Pokemon]
}

public struct Pokemon: Decodable {
    var name: String?
    var url: String?
}

