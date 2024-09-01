//
//  ListViewController.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    // MARK: - Variables
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .white
        return activityIndicator
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .heavyPurpleColor
        tableView.tableFooterView = UIView.init(frame: .zero)
        return tableView
    }()

    var failedFetchView: FailedView = {
        let view = FailedView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties
    private var datasource: TableViewDataSource<ListTableViewCell, MatchListViewModel>!
    private let viewModel = MatchListViewModel(service: Services())
    private var page = 0
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        failedFetchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = datasource
        
        setupBindings()

        page += 1
        viewModel.fetchShows(page: page)
    }

    // MARK: - Layout
    func setupLayout() {
        title = "Main Title".localized()

        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .heavyPurpleColor

        view.addSubview(tableView)
        tableView.addSubview(activityIndicator)
        view.addSubview(failedFetchView)

        let safeG = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: 0.0),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),

            failedFetchView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            failedFetchView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),
            failedFetchView.heightAnchor.constraint(equalToConstant: 150.0),
            failedFetchView.widthAnchor.constraint(equalToConstant: 200.0)
        ])

        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        datasource = TableViewDataSource<ListTableViewCell, MatchListViewModel>(viewModel: viewModel, tableView: tableView) { cell, model in
            let cellViewModel = MatchListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
    }

    // MARK: - Setup RxSwift Bindings
    private func setupBindings() {
        // Bind loading state
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        // Bind data updates
        viewModel.dataRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                self?.tableView.reloadData()
                self?.failedFetchView.isHidden = true
                self?.tableView.isHidden = false
            })
            .disposed(by: disposeBag)

        viewModel.teamDataRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] success in
            })
            .disposed(by: disposeBag)

        // Bind errors
        viewModel.errorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showFailedFetchView()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Helper Methods
    fileprivate func showFailedFetchView() {
        tableView.isHidden = true
        failedFetchView.isHidden = false
    }

    fileprivate func hideFailedFetchView() {
        tableView.isHidden = false
        activityIndicator.startAnimating()
    }

    private func loadMoreData() {
        viewModel.fetchShows(page: page)
    }
}

// MARK: - ListViewControllerViewControllerDelegate
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !viewModel.hasReachedLastPage && indexPath.row == viewModel.items.count - 1 {
            page += 1
            loadMoreData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShowDetailsViewController()
        vc.match = datasource.viewModel.items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - FailedViewProtocol
extension ListViewController: FailedViewProtocol {
    func retryAction() {
        hideFailedFetchView()
        loadMoreData()
    }
}
