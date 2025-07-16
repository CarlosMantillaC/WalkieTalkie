//
//  LoginViewController.swift
//  WalkieTalkie
//

//

import UIKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Iniciar Sesión"
        startObservingKeyboard()
        
        passwordTextField.textContentType = .oneTimeCode
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        presenter?.didTapLogin(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        presenter?.didTapRegister()
    }
    
    deinit {
        stopObservingKeyboard()
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func makeErrorAlert(_ error: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    func showError(_ error: String) {
        let alert = makeErrorAlert(error)
        present(alert, animated: true)
    }
}

extension LoginViewController: KeyboardScrollable {
    var keyboardScrollableView: UIScrollView {
        return scrollView
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
