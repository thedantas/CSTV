//
//  ListTableViewCell.swift
//  CounterStriker
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var teamOneImageView: UIImageView!
    @IBOutlet weak var teamTwoImageView: UIImageView!
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    @IBOutlet weak var nameLeagueLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLayout(){
        matchView.layer.cornerRadius = 16
    }
    
    func update(with viewModel: MatchListTableViewCellViewModel) {
        if viewModel.matchs.opponents?.count == 2 {
             if let imageTeamOneURL = viewModel.matchs.opponents?[0].team.imageUrl {
                 let url = URL(string: imageTeamOneURL)
                 teamOneImageView.kf.setImage(with: url, placeholder: viewModel.teamPlaceholderImage)
             } else {
                 teamOneImageView.image = viewModel.teamPlaceholderImage
             }
             teamOneLabel.text = viewModel.matchs.opponents?[0].team.name

             if let imageTeamTwoURL = viewModel.matchs.opponents?[1].team.imageUrl {
                 let url = URL(string: imageTeamTwoURL)
                 teamTwoImageView.kf.setImage(with: url, placeholder: viewModel.teamPlaceholderImage)
             } else {
                 teamTwoImageView.image = viewModel.teamPlaceholderImage
             }
             teamTwoLabel.text = viewModel.matchs.opponents?[1].team.name
         } else {
             if let imageTeamOneURL = viewModel.matchs.league?.image_url {
                 let url = URL(string: imageTeamOneURL)
                 teamOneImageView.kf.setImage(with: url, placeholder: viewModel.teamPlaceholderImage)
             } else {
                 teamOneImageView.image = viewModel.teamPlaceholderImage
             }
             teamOneLabel.text = viewModel.matchs.name
         }

         // Atualiza a imagem da liga
         if let imageLeagueURL = viewModel.matchs.league?.image_url {
             let url = URL(string: imageLeagueURL)
             leagueImageView.kf.setImage(with: url, placeholder: viewModel.teamPlaceholderImage)
         } else {
             leagueImageView.image = viewModel.teamPlaceholderImage
         }

         nameLeagueLabel.text = viewModel.matchs.league?.name

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E, HH:mm"
        
        if let date = dateFormatterGet.date(from:  viewModel.matchs.beginAt ?? "") {
            if  viewModel.matchs.status == .running {
                timerImageView.image = UIImage(named: "liveImage")
                timerLabel.isHidden = true
            } else {
                timerLabel.isHidden = false
                timerImageView.image = UIImage(named: "timerImage")
                timerLabel.text = (dateFormatterPrint.string(from: date))
            }
        } else {
            print("There was an error decoding the string")
        }
        
    }
    
}

extension ListTableViewCell: ReusableView, NibLoadableView { }
