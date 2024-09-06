//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

final class MainViewController: UIViewController {
    private let heightCell: Double = 44
    private let viewModel: MainViewModelProtocol
    
    private lazy var feedbackView: FeedbackView = .init()
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            PokemonTableViewCell.self,
            forCellReuseIdentifier: viewModel.forCellReuseIdentifier
        )
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.setDelegate(self)
        viewModel.fetchPokemons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        title = Constants.Strings.pokemons
    }
}

extension MainViewController: ViewCode {
    func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(feedbackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        feedbackView.attach(at: view)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPokemonList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: viewModel.forCellReuseIdentifier,
            for: indexPath
        ) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        guard let row = viewModel.getPokemonList().object(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.fill(row: row)
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = viewModel.getPokemonList().object(index: indexPath.row)?.url else {
            return
        }
        
        DetailRouter.show(from: navigationController, with: url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}

extension MainViewController: MainViewModelOutput {
    func loadedPokemonsWithSuccess() {
        DispatchQueue.main.async {
            self.feedbackView.dismiss()
            self.tableView.reloadData()
        }
    }
    
    func loadedPokemonsWithFailure(message: String) {
        DispatchQueue.main.async {
            self.feedbackView.showMessage(message)
        }
    }
    
    func willLoadPokemons(message: String) {
        DispatchQueue.main.async {
            self.feedbackView.startAnimating()
        }
    }
}
