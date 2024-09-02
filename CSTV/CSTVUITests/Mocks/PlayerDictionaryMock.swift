//
//  PlayerDictionaryMock.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import Foundation
@testable import CSTV

struct PlayerDictionaryMock {
    static func makePlayer(id: Int = 1, name: String? = "PlayerName", firstName: String? = "FirstName", lastName: String? = "LastName", imageURL: String? = "https://example.com/player.png", role: String? = "Top", bio: String? = "A great player", hometown: String? = "Somewhere") -> PlayerDictionary {
        return PlayerDictionary(
            id: id,
            name: name,
            firstName: firstName,
            lastName: lastName,
            imageURL: imageURL,
            role: role,
            bio: bio,
            hometown: hometown
        )
    }
}
