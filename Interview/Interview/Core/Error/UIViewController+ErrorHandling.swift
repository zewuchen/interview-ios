//
//  UIViewController+ErrorHandling.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import UIKit

protocol ErrorHandling: AnyObject {
    func showError(_ error: Error)
}

extension ErrorHandling where Self: UIViewController {
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Erro",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
