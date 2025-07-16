//
//  HomeViewController.swift
//  WalkieTalkie
//

//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inicio"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cerrar sesión",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
    }

    @objc private func didTapLogout() {
        presenter?.didTapLogout()
    }
}

extension HomeViewController: HomeViewProtocol {
    func showLogoutError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
