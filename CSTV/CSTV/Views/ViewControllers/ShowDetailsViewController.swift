//
//  ShowDetailsViewController.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit
import RxSwift
import RxCocoa

class ShowDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    //MARK: UI
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.backgroundColor = .heavyPurpleColor
        return v
    }()

    /// Team 1
    let teamOneImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.height/2
        return image
    }()
    let teamOneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = .white
        label.text = "Team One"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackTeamOneView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 66
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    let teamTwoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let teamTwoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Team Two"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackTeamTwoView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 66
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = .white
        label.text = "Hoje 21:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let versusLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = UIFont(name: "Roboto", size: 12)
        label.layer.opacity = 50.0
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let activityIndicator = UIActivityIndicatorView()

    // MARK: - Properties
    var tvShow: Team?
    var match: MatchsModel?
    private let viewModel = DetailsViewModel(service: Services())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButton()
        title = match?.league?.name
        dateLabel.text = formatDate(match?.beginAt ?? "")
        navigationItem.largeTitleDisplayMode = .never

        buildUI()
        bindViewModel()
        displayTeamsDetails()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func buildUI() {
        let backBTN = UIBarButtonItem(image: UIImage(named: "backImage"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        view.backgroundColor = .heavyPurpleColor
        self.view.addSubview(scrollView)
        scrollView.addSubview(teamOneImageView)
        scrollView.addSubview(teamOneLabel)
        scrollView.addSubview(teamTwoImageView)
        scrollView.addSubview(teamTwoLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(stackTeamOneView)
        scrollView.addSubview(stackTeamTwoView)
        scrollView.addSubview(versusLabel)
        setupContraint()
    }

    func setupContraint() {
        let safeG = view.safeAreaLayoutGuide
        let contentG = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 0.0),
            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0.0),
            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0.0),
            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: 0.0),

            versusLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 58.0),
            versusLabel.centerXAnchor.constraint(equalTo: safeG.centerXAnchor, constant: 0.0),

            teamOneImageView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 24.0),
            teamOneImageView.trailingAnchor.constraint(equalTo: versusLabel.leadingAnchor, constant: -20.0),
            teamOneImageView.heightAnchor.constraint(equalToConstant: 60),
            teamOneImageView.widthAnchor.constraint(equalToConstant: 60),

            teamOneLabel.topAnchor.constraint(equalTo: teamOneImageView.bottomAnchor, constant: 10.0),
            teamOneLabel.centerXAnchor.constraint(equalTo: teamOneImageView.centerXAnchor, constant: 0.0),

            teamTwoImageView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 24.0),
            teamTwoImageView.leadingAnchor.constraint(equalTo: versusLabel.trailingAnchor, constant: 20.0),
            teamTwoImageView.heightAnchor.constraint(equalToConstant: 60),
            teamTwoImageView.widthAnchor.constraint(equalToConstant: 60),

            teamTwoLabel.topAnchor.constraint(equalTo: teamTwoImageView.bottomAnchor, constant: 10.0),
            teamTwoLabel.centerXAnchor.constraint(equalTo: teamTwoImageView.centerXAnchor, constant: 0.0),

            dateLabel.topAnchor.constraint(equalTo: teamOneLabel.bottomAnchor, constant: 20.0),
            dateLabel.centerXAnchor.constraint(equalTo: safeG.centerXAnchor, constant: 0.0),

            stackTeamOneView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24.0),
            stackTeamOneView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0.0),
            stackTeamOneView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -58.0),


            stackTeamTwoView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24.0),
            stackTeamTwoView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0.0),
            stackTeamTwoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -58.0),

        ])
    }
    // MARK: - Helper Methods
    fileprivate func hideFailedFetchView() {
        activityIndicator.startAnimating()
    }

    fileprivate func displayTeamsDetails() {
        displayTeamOneDetails()
    }

    private func bindViewModel() {
        viewModel.itemsRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
            })
            .disposed(by: disposeBag)

        viewModel.errorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func displayTeamOneDetails() {
        activityIndicator.startAnimating()

        guard let opponents = match?.opponents, !opponents.isEmpty else {
            activityIndicator.stopAnimating()
            return
        }

        teamOneLabel.text = opponents[0].team.name

        if let imageTeamOneURL = opponents[0].team.imageUrl {
            teamOneImageView.setImage(withURL: imageTeamOneURL, placeholderImage: .init(named: "") ?? .remove)
        } else {
            teamOneImageView.image = .init(named: "") ?? .remove
        }

        viewModel.fetchTeam(teamID: opponents[0].team.id ?? 0)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] success in
                self?.viewModel.itemsRelay.value.forEach { item in
                    let view = TeamOneDetailView()
                    view.update(with: ShowDetailStackViewCellViewModel(model: item))
                    self?.stackTeamOneView.addArrangedSubview(view)
                }
                self?.viewModel.removeAllItems()
                self?.displayTeamTwoDetails()
                self?.loadViewIfNeeded()
                self?.updateFocusIfNeeded()
            }, onFailure: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func displayTeamTwoDetails() {
        activityIndicator.startAnimating()

        guard let opponents = match?.opponents, opponents.count > 1 else {
            activityIndicator.stopAnimating()
            return
        }

        teamTwoLabel.text = opponents[1].team.name

        if let imageTeamTwoURL = opponents[1].team.imageUrl {
            teamTwoImageView.setImage(withURL: imageTeamTwoURL, placeholderImage: .init(named: "") ?? .remove)
        } else {
            teamTwoImageView.image = .init(named: "") ?? .remove
        }

        viewModel.fetchTeam(teamID: opponents[1].team.id ?? 0)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] success in
                self?.viewModel.itemsRelay.value.forEach { item in
                    let view = TeamTwoDetailView()
                    view.update(with: ShowDetailStackViewCellViewModel(model: item))
                    self?.stackTeamTwoView.addArrangedSubview(view)
                }
            }, onFailure: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }

    private func handleError(_ error: Error) {
        activityIndicator.stopAnimating()
        ErrorHandler.sharedInstance.handleError(error, from: self)
    }
}

