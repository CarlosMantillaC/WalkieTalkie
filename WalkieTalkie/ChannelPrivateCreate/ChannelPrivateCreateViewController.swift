//
//  ChannelPrivateCreateViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelPrivateCreateViewController: UIViewController {

    var presenter: ChannelPrivateCreatePresenterProtocol?
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingKeyboard()

        title = "Crea un canal privado"
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
}

extension ChannelPrivateCreateViewController: ChannelPrivateCreateViewProtocol {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func show(error: String) {
        
    }
    
    func showSuccess(message: String) {
        
    }
}

extension ChannelPrivateCreateViewController: KeyboardScrollable {
    var keyboardScrollableView: UIScrollView? {
        nil
    }
}

