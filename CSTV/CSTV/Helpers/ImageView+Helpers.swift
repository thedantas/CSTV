//
//  ImageView+Helpers.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

extension UIImageView {

    func setImage(withURL urlString: String, placeholderImage: UIImage) {
        image = placeholderImage

        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        let session = URLSession.shared

        let datatask = session.dataTask(with: request) { (data, response, error) in
            if let imgData = data {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage.init(data: imgData)
                }
            }

        }
        datatask.resume()
    }
}
