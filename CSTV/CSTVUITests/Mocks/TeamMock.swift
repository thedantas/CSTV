//
//  TeamMock.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import Foundation
@testable import CSTV

struct TeamMock {
    static func makeTeam(id: Int = 1, name: String = "TeamName", acronym: String? = "TN", imageUrl: String? = "https://example.com/team.png", players: [PlayerDictionary] = [PlayerDictionaryMock.makePlayer()]) -> Team {
        return Team(
            id: id,
            name: name,
            acronym: acronym,
            imageUrl: imageUrl,
            players: players
        )
    }
}
