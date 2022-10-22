//
//  MyTableViewCell.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let id = "MyTableViewCell"
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cryptoImageView: UIImageView!
//    weak var timer: Timer?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    func showModel(coin: Coin) {
        if let id = coin.idIcon {
            let url = getURL(id: id)
            cryptoImageView.kf.setImage(with: url)
        } else {
            cryptoImageView.image = UIImage(named: "noImage")
        }
        fullName.text = coin.fullName
        tickerLabel.text = coin.ticker
        if (coin.price != nil) {
            priceLabel.text = "$\(round(coin.price!*1000)/1000)"
        } else {
            priceLabel.text = ""
        }
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true, block: { (timer) in
//            getData()
//            if let price = coin.price {
//                self.priceLabel.text = "$\(round(price*1000)/1000)"
//            }
//        })
    }
    
// Cells update price only when invisible
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
