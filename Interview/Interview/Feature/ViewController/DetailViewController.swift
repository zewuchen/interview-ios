//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation

import UIKit

public class DetailViewController: UIViewController {
    @StateObject var viewModel = ViewModel()
    var viewModelDetails = viewModel.pokemonDetails?
    var pokemonImageName = "bulbasaur.png"

    private let url: String
    let labelName = UILabel()
    let labelId = UILabel()
    let labelHeight = UILabel()
    let labelWeight = UILabel()
    let imageTapped = UITapGestureRecognizer(target: self, action: #selector(accessibilityTapped))
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .sizeToFit()
        imageView.image = UIImage(named: pokemonImageName)
        imageView.addGestureRecognizer(imageTapped)
		imageView.isUserInteractionEnabled = true
        return imageView
    }()

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        pokemonImage()
        view.addSubview(imageView)
        pokemonLabels()
        view.addSubview(labelName)
        view.addSubview(labelId)
        view.addSubview(labelHeight)
        view.addSubview(labelWeight)
    }

    @objc func accessibilityTapped(sender: UITapGestureRecognizer) {
		if sender.state == .ended {
			let utterance = AVSpeechUtterance(string: pokemonImageName)
		}
	}

    func pokemonImage() {
        imageId = viewModelDetails!.id ?? 1
        if imageId % 2 != 0 {
            if imageid % 5 == 0 {
                pokemonImageName = "charmander.png"
            } else {
                pokemonImageName = "bulbasaur.png"
            }
        } else {
            pokemonImageName = "squirtle.png"
        }
        imageView.image = UIImage(named: pokemonImageName)
        imageView.reloadData()
    }

    func pokemonLabels() {
        labelName.text = "Nome: \(viewModelDetails!.name ?? "Missigno")"
        labelId.text = "Número: \(viewModelDetails!.id ?? "0")"
        labelHeight.text = "Altura: \(viewModelDetails!.height ?? "0")"
        labelWeight.text = "Peso: \(viewModelDetails!.weight ?? "0")"
    }
}

extension DetailViewController: UIImageView {

    convenience init(named name: String) {
        self.init(frame: .zero)
        image = UIImage(named: name)
    }

}
