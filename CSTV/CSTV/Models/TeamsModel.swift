//
//  TeamsModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

struct Team: Decodable{
    let id: Int
    let name: String
    let acronym: String?
    let imageUrl: String?
    let players: [PlayerDictionary]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case acronym = "acronym"
        case imageUrl = "image_url"
        case players = "players"
    }
}

struct PlayerDictionary: Decodable{
    let id: Int
    let name: String?
    let firstName: String?
    let lastName: String?
    let imageURL: String?
    let role: String?
    let bio: String?
    let hometown: String?

    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "image_url"
        case role = "role"
        case bio = "bio"
        case hometown = "hometown"
    }
}

