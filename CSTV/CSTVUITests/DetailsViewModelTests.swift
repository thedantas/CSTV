//
//  DetailsViewModelTests.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import XCTest
import RxSwift
import RxCocoa

@testable import CSTV

class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailsViewModel!
    var mockService: MockService!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = DetailsViewModel(service: mockService)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchTeam_Success() {
        // Given
        let player = PlayerDictionary(id: 1, name: "Player1", firstName: "First", lastName: "Last", imageURL: "https://example.com/player.png", role: "Role", bio: "Bio", hometown: "Hometown")
        let team = Team(id: 1, name: "Team1", acronym: "T1", imageUrl: "https://example.com/team.png", players: [player])
        mockService.fetchTeamResult = .just(team)

        let expectation = self.expectation(description: "Expected fetchTeam to succeed and add players to itemsRelay")

        // Observa as mudanças de itemsRelay
        var receivedItems: [PlayerDictionary]?
        viewModel.itemsRelay
            .skip(1) // Pula o estado inicial
            .subscribe(onNext: { items in
                receivedItems = items
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchTeam(teamID: 1)
            .subscribe(onSuccess: { success in
                XCTAssertTrue(success, "Expected fetchTeam to succeed")
            }, onFailure: { error in
                XCTFail("Expected fetchTeam to succeed, but it failed with error: \(error)")
            })
            .disposed(by: disposeBag)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(receivedItems?.count, 1, "Expected one player to be added to itemsRelay")
    }

    func testFetchTeam_Failure() {
        // Given
        mockService.fetchTeamResult = .error(SwiftyRestKitError.serviceError)

        let expectation = self.expectation(description: "Expected fetchTeam to fail and send error to errorRelay")

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
            .subscribe(onSuccess: { _ in
                XCTFail("Expected fetchTeam to fail, but it succeeded")
            }, onFailure: { error in
                receivedError = error
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(receivedError, "Expected an error to be emitted")
    }

    func testAddItems() {
        // Given
        let player = PlayerDictionary(id: 1, name: "Player1", firstName: "First", lastName: "Last", imageURL: "https://example.com/player.png", role: "Role", bio: "Bio", hometown: "Hometown")

        // When
        viewModel.addItems([player])

        // Then
        XCTAssertEqual(viewModel.itemsRelay.value.count, 1, "Expected one player to be added to itemsRelay")
    }

    func testRemoveAllItems() {
        // Given
        let player = PlayerDictionary(id: 1, name: "Player1", firstName: "First", lastName: "Last", imageURL: "https://example.com/player.png", role: "Role", bio: "Bio", hometown: "Hometown")
        viewModel.addItems([player])

        // When
        viewModel.removeAllItems()

        // Then
        XCTAssertEqual(viewModel.itemsRelay.value.count, 0, "Expected all items to be removed from itemsRelay")
    }
}
