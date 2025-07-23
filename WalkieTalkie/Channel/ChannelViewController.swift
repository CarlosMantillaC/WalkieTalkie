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
    private var users: [String] = []
    private var fetchUsersTimer: Timer?
    
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
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startUserFetchTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopUserFetchTimer()
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
    
    private func startUserFetchTimer() {
        fetchUsersTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.presenter?.refreshUsers()
        }
        RunLoop.main.add(fetchUsersTimer!, forMode: .common)
    }
    
    private func stopUserFetchTimer() {
        fetchUsersTimer?.invalidate()
        fetchUsersTimer = nil
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
    
    func displayUsers(_ emails: [String]) {
        self.users = emails
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ChannelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        cell.emailLabel.text = users[indexPath.row]
        return cell
    }
}
