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
        setupTableView()
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
        guard let tableView = tableView else { return }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ChannelsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ChannelsCell"
        )
    }
}

extension ChannelsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.channelsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelsCell", for: indexPath) as? ChannelsTableViewCell
        else {
            return UITableViewCell()
        }

        presenter?.configure(cell: cell, at: indexPath.row)
        return cell
    }
}

extension ChannelsViewController: ChannelsViewProtocol {
    func reloadData() {
        tableView?.reloadData()
    }

    func showError(message: String) {
        print("Error: \(message)")
    }
}

