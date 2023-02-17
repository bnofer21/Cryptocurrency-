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
}

class CryptoViewController: UIViewController, CryptoViewInput {
    
    var output: CryptoViewOutput?
    
    var cryptoSection: CryptoSectionModel?
    var cryptoView = CryptoTableView()
    
    override func loadView() {
        view = cryptoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print(output == nil)
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
    }
    
    @objc func filterCoins(sender: SelectorButton) {
        guard let type = sender.moneyType else { return }
        output?.filterChanged(showType: type)
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
