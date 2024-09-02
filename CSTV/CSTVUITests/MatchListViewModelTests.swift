//
//  MatchListViewModelTests.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import XCTest
import RxSwift
import RxCocoa

@testable import CSTV

class MatchListViewModelTests: XCTestCase {
    var viewModel: MatchListViewModel!
    var mockService: MockService!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = MatchListViewModel(service: mockService)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchShows_Success() {
        // Given
        let match = MatchsModel(id: 1, name: "Test Match", beginAt: "2024-09-01T23:30:00Z", matchID: "match_123", opponents: nil, currentGame: nil, results: nil, league: nil, live: nil, status: .running)
        mockService.fetchAllMatchesResult = .just([match])

        let expectation = self.expectation(description: "Expected fetchShows to succeed")

        // Observa as mudanças de isLoading
        var isLoadingStates = [Bool]()
        viewModel.isLoading
            .subscribe(onNext: { isLoading in
                isLoadingStates.append(isLoading)
            })
            .disposed(by: disposeBag)

        // Observa as mudanças de dataRelay
        var receivedData: [MatchsModel]?
        viewModel.dataRelay
            .skip(1) // Pula o estado inicial
            .subscribe(onNext: { data in
                receivedData = data
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchShows(page: 1)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(isLoadingStates, [true, false], "Expected isLoading to emit [true, false]")
        XCTAssertEqual(receivedData?.count, 1, "Expected one match to be added")
        XCTAssertEqual(viewModel.items.count, 1, "Expected one match to be added to items")
    }

    func testFetchShows_Failure() {
        // Given
        mockService.fetchAllMatchesResult = .error(SwiftyRestKitError.serviceError)

        let expectation = self.expectation(description: "Expected fetchShows to fail")

        // Observa as mudanças de errorRelay
        var receivedError: Error?
        viewModel.errorRelay
            .subscribe(onNext: { error in
                receivedError = error
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchShows(page: 1)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(receivedError, "Expected an error to be emitted")
    }

    func testFetchTeam_Success() {
        // Given
        let team = Team(id: 1, name: "Test Team", acronym: "TT", imageUrl: "https://example.com/team.png", players: [])
        mockService.fetchTeamResult = .just(team)

        let expectation = self.expectation(description: "Expected fetchTeam to succeed")

        // Observa as mudanças de isLoading
        var isLoadingStates = [Bool]()
        viewModel.isLoading
            .subscribe(onNext: { isLoading in
                isLoadingStates.append(isLoading)
            })
            .disposed(by: disposeBag)

        // Observa as mudanças de teamDataRelay
        var teamData: Bool?
        viewModel.teamDataRelay
            .skip(1) // Pula o estado inicial
            .subscribe(onNext: { data in
                teamData = data
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchTeam(teamID: 1)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(isLoadingStates, [true, false], "Expected isLoading to emit [true, false]")
        XCTAssertEqual(teamData, true, "Expected teamDataRelay to emit true")
    }

    func testFetchTeam_Failure() {
        // Given
        mockService.fetchTeamResult = .error(SwiftyRestKitError.serviceError)

        let expectation = self.expectation(description: "Expected fetchTeam to fail")

        // Observa as mudanças de errorRelay
        var receivedError: Error?
        viewModel.errorRelay
            .subscribe(onNext: { error in
                receivedError = error
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchTeam(teamID: 1)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(receivedError, "Expected an error to be emitted")
    }
}
