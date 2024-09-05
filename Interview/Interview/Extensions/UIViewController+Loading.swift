//
//  UIViewController+Loading.swift
//  Interview
//
//  Created by Guilherme Prata Costa on 05/09/24.
//

import UIKit

protocol Loadable: AnyObject {
    var loadingManager: LoadingManaging { get }
    func showLoading()
    func hideLoading(completion: (() -> Void)?)
}

extension Loadable where Self: UIViewController {
    func showLoading() {
        loadingManager.showLoading(in: view)
    }
    
    func hideLoading(completion: (() -> Void)? = nil) {
        loadingManager.hideLoading(from: view, completion: completion)
    }
}

protocol LoadingManaging {
    func showLoading(in view: UIView)
    func hideLoading(from view: UIView, completion: (() -> Void)?)
}

class LoadingManager: LoadingManaging {
    private var loadingView: UIView?
    
    func showLoading(in view: UIView) {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.loadingView = loadingView
        loadingView.startLoading()
    }
    
    func hideLoading(from view: UIView, completion: (() -> Void)? = nil) {
        guard let loadingView = self.loadingView else {
            completion?()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                loadingView.alpha = 0
            } completion: { finished in
                guard finished else { return }
                loadingView.removeFromSuperview()
                self.loadingView = nil
                completion?()
            }
        }
    }
}
