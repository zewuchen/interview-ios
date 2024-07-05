//
//  MainViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import UIKit

public class MainViewController: UIViewController {
    @StateObject var viewModel = ViewModel()
    var viewModelList = viewModel.pokemonListed
    //lazy var para a tabela ser recreada toda vez.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableViewConstrain()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }

    func tableViewConstrain() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true,
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true,
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true,
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Custom
        let pokemon = viewModelList[indexPath.row]
        let info = viewModelList.getDetailPokemon(pokemon: pokemon)
        cell.backgroundConfig.backgroundColor = viewModelList.colorCell(pokemon: pokemon)
        cell.label.text = "\(info.id) - \(info.name.capitalized)"
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
        let url = viewModelList[indexPath.row].url
        navigationController?.pushViewController(DetailViewController(url: url), animated: true)
    }
}

class CustomCell: UITableViewCell {
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
    }
}