//
//  ViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var typeSelect: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var searchArray = [Coin]()
    var isSearching = false
    let search = UISearchController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        tableView.allowsSelection = false
        while resultsReturn.count == 0 {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    @IBAction func typeSwitched(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Count of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        isSearching ? (count = searchArray.count) : (count = coinArray(type: typeSelect.selectedSegmentIndex).count)
        return count
    }
    
    // Configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as? MyTableViewCell) else { fatalError() }
        if resultsReturn.count != 0 {
            isSearching ? cell.showModel(coin: searchArray[indexPath.row]) : cell.showModel(coin: coinArray(type: typeSelect.selectedSegmentIndex)[indexPath.row])
        }
        return cell
    }
    
    // Favorite swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeImage: UIImage {
            var image = UIImage()
            if isSearching {
                if favArray.contains(searchArray[indexPath.row]) {
                    image = UIImage(systemName: "heart.fill")!
                } else {
                    image = UIImage(systemName: "heart")!
                }
            } else {
                if favArray.contains(coinArray(type: typeSelect.selectedSegmentIndex)[indexPath.row]) {
                    image = UIImage(systemName: "heart.fill")!
                } else {
                    image = UIImage(systemName: "heart")!
                }
            }
            return image
        }
        let swipeRead = UIContextualAction(style: .normal, title: "") { [self] (action, view, sucess) in
            if !favArray.contains(where: { value -> Bool in
                return isSearching ? value.ticker == searchArray[indexPath.row].ticker : value.ticker == coinArray(type: self.typeSelect.selectedSegmentIndex)[indexPath.row].ticker
            }) {
                isSearching ? favArray.append(self.searchArray[indexPath.row]) : favArray.append(coinArray(type: self.typeSelect.selectedSegmentIndex)[indexPath.row])
                tableView.reloadData()
            } else {
                favArray = favArray.filter({ value -> Bool in
                    return isSearching ? value != searchArray[indexPath.row] : value != coinArray(type: self.typeSelect.selectedSegmentIndex)[indexPath.row]
                })
                tableView.reloadData()
            }
            print(favArray)
        }
        swipeRead.image = swipeImage
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}

// Search Update function
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            print(searchController.searchBar.text!)
            isSearching = true
            searchArray = coinArray(type: typeSelect.selectedSegmentIndex).filter({ value -> Bool in
                guard let search = searchController.searchBar.text else { return false }
                return value.ticker.contains(search) || value.fullName.contains(search)
            })
            tableView.reloadData()
        }
    }
    
}

