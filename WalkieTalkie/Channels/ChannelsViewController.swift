//
//  ChannelsViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ChannelsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista de Canales"
        
        setupButtons()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        guard let tableView = tableView else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChannelsTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelsCell")
        tableView.backgroundColor = .clear
    }
    
    private func setupButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Unirme", style: .plain, target: self, action: #selector(joinChannel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Crear", style: .plain, target: self, action: #selector(createChannel))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc private func joinChannel() {
        presenter?.joinChannelTapped()
    }
    
    @objc private func createChannel() {
        presenter?.createChannelTapped()
    }
}

extension ChannelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.channelsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelsCell", for: indexPath) as? ChannelsTableViewCell else {
            return UITableViewCell()
        }
        
        presenter?.configure(cell: cell, at: indexPath.row)
        return cell
    }
}

extension ChannelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectChannel(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChannelsViewController: ChannelsViewProtocol {
    func reloadData() {
        tableView?.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

