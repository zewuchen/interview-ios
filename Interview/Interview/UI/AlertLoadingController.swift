//
//  AlertLoadingController.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

final class AlertLoadingController {
    
    static let shared: AlertLoadingController = .init()
    
    private init() {}
    
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 95).isActive = true
                
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20).isActive = true
        
        return alert
    }()
    
    func startLoading(from nav: UINavigationController?, title: String) {
        alert.title = title
        nav?.present(alert, animated: true)
    }
    
    func stopAnimation() {
        alert.dismiss(animated: true)
    }
}
