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

        presenter?.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cerrar sesión",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
    }

    @IBAction func talkButtonPressed(_ sender: UIButton) {
        presenter?.startTalking()
    }

    @IBAction func talkButtonReleased(_ sender: UIButton) {
        presenter?.stopTalking()
    }

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        presenter?.didTapExit()
    }

    @objc private func didTapLogout() {
        presenter?.didTapLogout()
    }
}

extension ChannelViewController: ChannelViewProtocol {
    func setChannelName(_ name: String) {
        nameChannelLabel.text = name
    }
    
    func showLogoutError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
