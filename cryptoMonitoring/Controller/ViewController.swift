//
//  ViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = CryptoTableView()
    
    var coins = [Coin]()
    var searchCoins = [Coin]()
    var filterCoins = [Coin]()
    var state = Resources.ShowCase.def
    let search = UISearchBar()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCoins()
        setTargets()
    }
    
    private func setupView() {
        navigationItem.titleView = search
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
    }
    
    func showCancel(_ bool: Bool) {
        if bool {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tableView.cancelButton)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func setTargets() {
        tableView.setTarget(target: self, action: #selector(dismissKeyboard))
    }
    
    private func fetchCoins() {
        Network.shared.getData { coins in
            self.coins = coins
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func dismissKeyboard() {
        search.endEditing(true)
    }
    
    @objc func filterCoins(sender: SelectorButton) {
        switch sender.titleLabel?.text {
        case Resources.SelectButtons.all.rawValue:
            state = .def
        case Resources.SelectButtons.fiat.rawValue:
            state = .filter
            filterCoins = coins.filter({ $0.moneyType == 0})
        default:
            state = .filter
            filterCoins = coins.filter({ $0.moneyType == 1})
            
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .def:
            return coins.count
        case .search:
            return searchCoins.count
        case .filter:
            return filterCoins.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.id, for: indexPath) as? CryptoCell else { return UITableViewCell() }
        switch state {
        case .def:
            cell.viewModel = CellViewModel(coin: coins[indexPath.row])
        case .search:
            cell.viewModel = CellViewModel(coin: searchCoins[indexPath.row])
        case .filter:
            cell.viewModel = CellViewModel(coin: filterCoins[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CryptoTableHeader.id) as? CryptoTableHeader else { return UIView() }
        header.clipsToBounds = true
        for button in header.buttons {
            button.addTarget(self, action: #selector(filterCoins(sender:)), for: .touchUpInside)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search update view func
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            tableView.reloadData()
        } else {
            if state == .filter {
                searchCoins = filterCoins.filter({ $0.ticker.contains(searchText) || $0.fullName.contains(searchText)})
            } else {
                searchCoins = coins.filter({ $0.ticker.contains(searchText) || $0.fullName.contains(searchText)})
            }
            state = .search
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showCancel(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        state = .def
        tableView.reloadData()
        showCancel(false)
    }

}

