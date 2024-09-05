//
//  PokemonListView.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 04/09/24.
//

import Foundation
import UIKit

final class PokemonListView: UIView {

    static let cellSize = CGFloat(42)

    private let cellIdentifier = "PokemonListCellIdentifier"
    
    private var pokemonsListModel = [PokemonListCellModel]()
    var onPokemonSelected: ((Int) -> Void)?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonListCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        return tableView
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        addSubviews()
        configureConstraints()
    }
    
    func configure(with model: [PokemonListCellModel]) {
        self.pokemonsListModel = model
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListView {

    func addSubviews() {
        addSubview(tableView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension PokemonListView: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsListModel.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PokemonListCellView else {
            return UITableViewCell()
        }
        
        let model = pokemonsListModel[indexPath.row]
        cell.setupCell(with: model)

        return cell
    }
}

extension PokemonListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PokemonListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPokemonSelected?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
