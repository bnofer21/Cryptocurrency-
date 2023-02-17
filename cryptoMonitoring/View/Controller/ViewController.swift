//
//  ViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    var tableView = CryptoTableView()
    
    var coins = [Coin]()
    var searchCoins = [Coin]()
    var filterCoins = [Coin]()
    var isSearching = false
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
    
//    func showCancel(_ bool: Bool) {
//        if bool {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tableView.cancelButton)
//        } else {
//            navigationItem.rightBarButtonItem = nil
//        }
//    }
    
    private func setTargets() {
//        tableView.setTarget(target: self, action: #selector(dismissKeyboard))
    }
    
    private func fetchCoins() {
//        Network.shared.getData { coins in
//            self.coins = coins
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
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
        if let text = search.text {
            searchBar(search, textDidChange: text)
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchCoins.count
        } else {
            switch state {
            case .def:
                return coins.count
            case .filter:
                return filterCoins.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.id, for: indexPath) as? CryptoCell else { return UITableViewCell() }
        if isSearching {
            cell.viewModel = CellViewModel(coin: searchCoins[indexPath.row])
        } else {
            switch state {
            case .def:
                cell.viewModel = CellViewModel(coin: coins[indexPath.row])
            case .filter:
                cell.viewModel = CellViewModel(coin: filterCoins[indexPath.row])
            }
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
        if !searchText.isEmpty {
            isSearching = true
            if state == .filter {
                searchCoins = filterCoins.filter({ $0.ticker.contains(searchText) || $0.fullName.contains(searchText)})
            } else {
                searchCoins = coins.filter({ $0.ticker.contains(searchText) || $0.fullName.contains(searchText)})
            }
        } else {
            isSearching = false
        }
            tableView.reloadData()
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        showCancel(true)
//    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        showCancel(false)
//    }

}

