//
//  ListUsersViewController.swift
//  WalkieTalkie
//

//

import UIKit

class ListUsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ListUsersPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Usuarios Conectados"
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListUsersTableViewCell", bundle: nil), forCellReuseIdentifier: "ListUsersTableViewCell")
        tableView.rowHeight = 91
    }
}

extension ListUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsersTableViewCell", for: indexPath) as? ListUsersTableViewCell else {
            return UITableViewCell()
        }
        presenter?.configure(cell: cell, at: indexPath)
        return cell
    }
}

extension ListUsersViewController: ListUsersViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
