//
//  ChannelViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelViewController: UIViewController {
    
    @IBOutlet weak var nameChannelLabel: UILabel!
    @IBOutlet weak var talkToPushButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var presenter: ChannelPresenterProtocol?

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

extension ChannelViewController: ChannelViewProtocol {
    func showLogoutError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
