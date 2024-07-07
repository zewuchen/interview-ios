//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

public class MainViewController: UIViewController {
    private let mainTableView = MainTableView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        mainTableView.getPokemonData()
        self.navigationItem.title = "Lista de Pokemon"
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
        
        mainTableView.didSelectRow = { [weak self] index in
            self?.startDetailViewController(id: index)
        }
    }
    
    private func startDetailViewController(id: Int) {
        let detailViewController = DetailViewController(id: id)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
