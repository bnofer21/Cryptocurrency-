//
//  CryptoViewController.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.02.2023.
//

import UIKit

protocol CryptoViewInput: AnyObject {
    func updateForSection(_ section: CryptoSectionModel)
}

protocol CryptoViewOutput {
    func viewDidLoad()
    func filterChanged(showType: Resources.SelectButtons)
    func searchCoin(searchText: String, moneyType: Resources.SelectButtons)
}

class CryptoViewController: UIViewController, CryptoViewInput {
    
    var output: CryptoViewOutput?
    var cryptoSection: CryptoSectionModel?
    
    var cryptoView = CryptoTableView()
    let searchBar = UISearchBar()
    
    var isSearching = false
    var selectedType = Resources.SelectButtons.all
    var state = Resources.ShowCase.def
    
    private var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    override func loadView() {
        view = cryptoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTargets()
        output?.viewDidLoad()
    }
    
    func updateForSection(_ section: CryptoSectionModel) {
        self.cryptoSection = section
        DispatchQueue.main.async {
            self.cryptoView.reloadData()
        }
    }
    
    private func setupView() {
        cryptoView.delegate = self
        cryptoView.dataSource = self
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func showCancel(_ bool: Bool) {
        if bool {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func setTargets() {
        cancelButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    
    @objc func filterCoins(sender: SelectorButton) {
        guard let type = sender.moneyType else { return }
        selectedType = type
        output?.filterChanged(showType: type)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
}

extension CryptoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoSection?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cryptoSection?.rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model!.cellIdentifier, for: indexPath) as? CryptoBaseCell else { return UITableViewCell()}
        cell.model = model
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension CryptoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isSearching = true
            output?.searchCoin(searchText: searchText, moneyType: selectedType)
        } else {
            isSearching = false
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showCancel(true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        showCancel(false)
    }
}
