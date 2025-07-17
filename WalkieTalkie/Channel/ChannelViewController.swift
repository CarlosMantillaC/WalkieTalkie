//
//  ChannelViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelViewController: UIViewController {
    
    @IBOutlet weak var nameChannelLabel: UILabel!
    @IBOutlet weak var talkToPushButton: UIButton!
    
    var presenter: ChannelPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Salir",
            style: .plain,
            target: self,
            action: #selector(didTapExit)
        )
    }

    @IBAction func talkButtonPressed(_ sender: UIButton) {
        presenter?.startTalking()
    }

    @IBAction func talkButtonReleased(_ sender: UIButton) {
        presenter?.stopTalking()
    }

    @objc private func didTapExit() {
        presenter?.didTapExit()
    }
}

extension ChannelViewController: ChannelViewProtocol {
    func setChannelName(_ name: String) {
        nameChannelLabel.text = name
    }
}
