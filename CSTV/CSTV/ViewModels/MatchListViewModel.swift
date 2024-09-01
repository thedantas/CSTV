//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import RxSwift
import RxCocoa

class MatchListViewModel: ListViewModel {
    typealias Model = MatchsModel

    // MARK: - Properties
    private let service: Gettable?
    private(set) var items = [MatchsModel]()
    private(set) var hasReachedLastPage: Bool = false

    // RxSwift Relays
    let dataRelay = BehaviorRelay<[MatchsModel]>(value: [])
    let teamDataRelay = BehaviorRelay<Bool>(value: false)
    let errorRelay = PublishRelay<Error>()
    let isLoading = BehaviorRelay(value: false)

    // Dispose bag for RxSwift
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init<S: Gettable>(service: S) {
        self.service = service
    }

    // MARK: - ListViewModel Conformance
    func addItems(_ items: [Model]) {
        self.items.append(contentsOf: items)
        self.items.sort { $0.status == .running && $1.status != .running }

        dataRelay.accept(self.items)
    }

    func removeAllItems() {
        items.removeAll()
        dataRelay.accept(self.items)
    }

    // MARK: - Fetch data
    func fetchShows(page: Int) {
        guard let service = service as? Services else {
            errorRelay.accept(SwiftyRestKitError.serviceError)
            return
        }

        isLoading.accept(true)

        service.fetchAllMatches(page: page)
            .subscribe(onSuccess: { [weak self] shows in
                self?.isLoading.accept(false)
                if shows.isEmpty {
                    self?.hasReachedLastPage = true
                }
                self?.addItems(shows)
            }, onFailure: { [weak self] error in
                self?.isLoading.accept(false)
                if let restError = error as? SwiftyRestKitError, restError == .resourceNotFound {
                    self?.hasReachedLastPage = true
                }
                self?.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }

    func fetchTeam(teamID: Int) {
        guard let service = service as? Services else {
            errorRelay.accept(SwiftyRestKitError.serviceError)
            return
        }

        isLoading.accept(true)

        service.fetchTeam(teamID: teamID)
            .subscribe(onSuccess: { [weak self] team in
                self?.isLoading.accept(false)
                self?.teamDataRelay.accept(true)

            }, onFailure: { [weak self] error in
                self?.isLoading.accept(false)
                if let restError = error as? SwiftyRestKitError, restError == .resourceNotFound {
                    self?.hasReachedLastPage = true
                }
                self?.errorRelay.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
