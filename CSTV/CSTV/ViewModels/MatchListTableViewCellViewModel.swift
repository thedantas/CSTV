//
//  MatchListTableViewCellViewModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

struct MatchListTableViewCellViewModel {

    // MARK: - Properties
    let teamPlaceholderImage: UIImage
    var matchs: MatchsModel

    // MARK: - Init
    init(model: MatchsModel) {
        self.matchs = model

        if let image = UIImage(named: "teamDefaultImage") {
            self.teamPlaceholderImage = image
        } else {
            self.teamPlaceholderImage = UIImage(systemName: "photo") ?? UIImage() // Valor padrão caso a imagem não seja encontrada
        }
    }
}
