//
//  TeamOneDetailView.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit

class TeamOneDetailView: UIView {

    let playerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurpleColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 12)
        label.textColor = .accentColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .heavyPurpleColor
        addSubview(playerView)
        addSubview(playerImageView)
        addSubview(nameLabel)
        addSubview(nickNameLabel)
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            playerView.widthAnchor.constraint(equalToConstant: 180.0),
            playerView.heightAnchor.constraint(equalToConstant: 54.0),
            playerView.topAnchor.constraint(equalTo: topAnchor),
            playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -2),

            playerImageView.widthAnchor.constraint(equalToConstant: 48.5),
            playerImageView.heightAnchor.constraint(equalToConstant: 48.5),
            playerImageView.topAnchor.constraint(equalTo: topAnchor, constant: -2.5),
            playerImageView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 113.76),

            nickNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nickNameLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -16),

            nameLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -16)
        ])


    }

    func update(with viewModel: ShowDetailStackViewCellViewModel) {
        if let imageLeague = viewModel.matchs.imageURL {
            playerImageView.setImage(withURL: imageLeague, placeholderImage: viewModel.playersPlaceholderImage)
        } else {
            playerImageView.image = viewModel.playersPlaceholderImage
        }
        nickNameLabel.text = viewModel.matchs.name

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

