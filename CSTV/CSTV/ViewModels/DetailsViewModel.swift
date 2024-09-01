//
//  DetailsViewModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import RxSwift
import RxCocoa

class DetailsViewModel {
    typealias Model = PlayerDictionary

    // MARK: - Properties
    private let service: Services
    private let disposeBag = DisposeBag()

    private(set) var itemsRelay = BehaviorRelay<[PlayerDictionary]>(value: [])
    private(set) var hasReachedLastPageRelay = BehaviorRelay<Bool>(value: false)
    let errorRelay = PublishRelay<Error>()

    // MARK: - Init
    init(service: Services) {
        self.service = service
    }

    // MARK: - ListViewModel Conformance
    func addItems(_ items: [Model]) {
        var currentItems = itemsRelay.value
        currentItems.append(contentsOf: items)
        itemsRelay.accept(currentItems)
    }

    func removeAllItems() {
        itemsRelay.accept([])
    }

    // MARK: - Fetch data
    func fetchTeam(teamID: Int) -> Single<Bool> {
        return service.fetchTeam(teamID: teamID)
            .map { [weak self] team in
                self?.addItems(team.players)
                return true
            }
            .catch { [weak self] error in
                if let restError = error as? SwiftyRestKitError, restError == .resourceNotFound {
                    self?.hasReachedLastPageRelay.accept(true)
                }
                self?.errorRelay.accept(error)
                return Single.just(false)
            }
    }
}
