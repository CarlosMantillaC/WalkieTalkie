//
//  ChannelPrivateJoinViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelPrivateJoinViewController: UIViewController {

    var presenter: ChannelPrivateJoinPresenterProtocol?
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
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let pin = pinTextField.text, !pin.isEmpty else {
            showError(error: "Por favor, rellene todos los campos.")
            return
        }
        
        guard pin.count == 4 else {
            showError(error: "El PIN debe tener 4 dígitos.")
            return
        }
        
        guard Int(pin) != nil else {
            showError(error: "El PIN debe ser numérico.")
            return
        }
        
        presenter?.joinChannel(name: name, pin: pin)
    }
}

extension ChannelPrivateJoinViewController: ChannelPrivateJoinViewProtocol {
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

extension ChannelPrivateJoinViewController: KeyboardScrollable {
    var keyboardScrollableView: UIScrollView? {
        nil
    }
}
