//
//  CustomIV.swift
//  cryptoMonitoring
//
//  Created by Юрий on 16.12.2022.
//
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomIV: UIImageView {
    var idIconStored: String?
    func loadImage(idIcon: String) {
        idIconStored = idIcon
        image = UIImage(named: "noImage")
        if let img = imageCache.object(forKey: NSString(string: idIconStored!)) {
            image = img
            return
        }
        guard let url = URL(string: makeIconUrl(idIcon)) else { return }
        idIconStored = idIcon
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    let tempImg = UIImage(data: data!)
                    if self.idIconStored == idIcon {
                        self.image = tempImg
                    }
                    imageCache.setObject(tempImg!, forKey: NSString(string: idIcon))
                }
            }
        }.resume()
    }
    
    private func makeIconUrl(_ idIcon: String) -> String {
        var urlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/"
        let editId = idIcon.replacingOccurrences(of: "-", with: "")
        urlString.append(editId)
        urlString.append(".png")
        return urlString
    }
}
