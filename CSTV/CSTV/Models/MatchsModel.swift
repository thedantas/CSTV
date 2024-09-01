//
//  MatchsModel.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

struct MatchsModel: Decodable {
    let id: Int?
    let name: String?
    let beginAt: String?
    let matchID: String?
    let opponents: [OpponentsDictionary]?
    let currentGame: VideoGameName?
    let results: [ResultsDictionary]?
    let league: League?
    let live: MatchLive?
    let status: MatchStatus

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case beginAt = "begin_at"
        case matchID = "match_id"
        case opponents = "opponents"
        case currentGame = "videogame"
        case results = "results"
        case league = "league"
        case live = "live"
        case status = "status"
    }

    struct OpponentsDictionary: Decodable {
        let team: TeamDictionary

        private enum CodingKeys: String, CodingKey {
            case team = "opponent"
        }
    }

    struct ResultsDictionary: Decodable {
        let teamID: Int
        let score: Int

        private enum CodingKeys: String, CodingKey {
            case teamID = "team_id"
            case score = "score"
        }
    }

    struct VideoGameName: Decodable {
        let name: String

        private enum CodingKeys: String, CodingKey {
            case name = "name"
        }
    }

    struct TeamDictionary: Decodable {
        let id: Int?
        let name: String
        let acronym: String?
        let imageUrl: String?

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case acronym = "acronym"
            case imageUrl = "image_url"
        }
    }

    struct League: Decodable {
        let id: Int
        let image_url: String?
        let modified_at: String?
        let name: String
        let slug: String
        let url: String?
    }

    struct MatchLive: Decodable {
        public let opensAt: Date?

        private enum CodingKeys: String, CodingKey {
            case opensAt = "opens_at"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let timestamp = try? container.decode(Double.self, forKey: .opensAt) {
                self.opensAt = Date(timeIntervalSince1970: timestamp)
            }
            else if let dateString = try? container.decode(String.self, forKey: .opensAt) {
                if let timestamp = Double(dateString) {
                    self.opensAt = Date(timeIntervalSince1970: timestamp)
                } else {
                    self.opensAt = nil
                }
            } else {
                self.opensAt = nil
            }
        }
    }

    enum MatchType: String, Decodable {
        case best_of, custom, ow_best_of
    }

    enum MatchStatus: String, Decodable {
        case not_started, running, finished
    }
}
