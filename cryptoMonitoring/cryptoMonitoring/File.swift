//
//  File.swift
//  cryptoMonitoring
//
//  Created by Юрий on 03.10.2022.
//

import Foundation
import UIKit

var favArray = [Coin]()

func coinArray(type: Int) -> [Coin] {
    var coins = [Coin]()
    if type < 2 {
        coins = resultsReturn.filter({ value -> Bool in
            return value.moneyType == type
        })
    } else if type == 2 {
        coins = resultsReturn
    } else {
        coins = favArray
    }
    return coins
}

func getURL (id: String) -> URL {
    var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
    let editId = id.replacingOccurrences(of: "-", with: "")
    urlString.append(editId)
    urlString.append(".png")
    let url = URL(string: urlString)
    return url!
}

