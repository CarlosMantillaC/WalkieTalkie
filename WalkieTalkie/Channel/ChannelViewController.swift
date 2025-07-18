//
//  ChannelViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameChannelLabel: UILabel!
    @IBOutlet weak var talkToPushButton: UIButton!
    
    var presenter: ChannelPresenterProtocol?
    private var gradientLayer: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        styleUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Salir",
            style: .plain,
            target: self,
            action: #selector(didTapExit)
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientBackground()
    }
    
    @IBAction func talkButtonPressed(_ sender: UIButton) {
        presenter?.startTalking()
        updateTalkButtonImage(isTalking: true)
    }
    
    @IBAction func talkButtonReleased(_ sender: UIButton) {
        presenter?.stopTalking()
        updateTalkButtonImage(isTalking: false)
    }
    
    @objc private func didTapExit() {
        presenter?.didTapExit()
    }
}

extension ChannelViewController {
    private func styleUI() {
        talkToPushButton.layer.cornerRadius = 20
        talkToPushButton.layer.borderWidth = 2
        talkToPushButton.layer.borderColor = UIColor.white.cgColor
        talkToPushButton.clipsToBounds = true
        updateTalkButtonImage(isTalking: false)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func updateTalkButtonImage(isTalking: Bool) {
        let systemName = isTalking ? "mic.fill" : "mic.slash.fill"
        let image = UIImage(systemName: systemName)
        talkToPushButton.setImage(image, for: .normal)
        talkToPushButton.tintColor = .white
        talkToPushButton.setTitle("", for: .normal)
    }
}

extension ChannelViewController: ChannelViewProtocol {
    func setChannelName(_ name: String) {
        nameChannelLabel.text = name
    }
}
