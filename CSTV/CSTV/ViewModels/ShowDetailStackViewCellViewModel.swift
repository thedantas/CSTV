//
//  ShowDetailStackViewCellViewModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

struct ShowDetailStackViewCellViewModel {

    // MARK: - Properties
    let playersPlaceholderImage: UIImage
    var matchs: PlayerDictionary

    // MARK: - Init
    init(model: PlayerDictionary) {
        self.matchs = model

        if let image = UIImage(named: "playerDefaultImage") {
            self.playersPlaceholderImage = image
        } else {
            self.playersPlaceholderImage = UIImage(systemName: "person.crop.circle") ?? UIImage() 
        }
    }
}
