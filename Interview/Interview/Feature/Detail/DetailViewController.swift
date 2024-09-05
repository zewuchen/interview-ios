//
//  DetailViewController.swift
//  Interview
//
//  Created by Zewu Chen on 28/06/24.
//

import Foundation

import UIKit

public class DetailViewController: UIViewController {
    
    // MARK: Variables
    var viewModel: DetailViewModelProtocol
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.coordinator?.onFinish()
    }
}
