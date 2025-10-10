//
//  ChannelPrivateCreateViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelPrivateCreateViewController: UIViewController {

    var presenter: ChannelPrivateCreatePresenterProtocol?
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startObservingKeyboard()
        configureViewContainer()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientBackground()
    }

    deinit {
        stopObservingKeyboard()
    }
    
    func configureViewContainer() {
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        viewContainer.layer.cornerRadius = 20
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        viewContainer.clipsToBounds = true
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let pin = pinTextField.text, !pin.isEmpty else {
            showError(error: "Por favor, rellene todos los campos.")
            return
        }
        presenter?.createChannel(name: name, pin: pin)
    }
}

extension ChannelPrivateCreateViewController: ChannelPrivateCreateViewProtocol {
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccess(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.presenter?.router?.dismiss()
        }))
        present(alert, animated: true)
    }
}

extension ChannelPrivateCreateViewController: KeyboardScrollable {
    var keyboardScrollableView: UIScrollView? {
        nil
    }
}

