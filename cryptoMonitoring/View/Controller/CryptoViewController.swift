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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cryptoSection?.rows[indexPath.row].cellHeight ?? 0)
    }
    
    
}
