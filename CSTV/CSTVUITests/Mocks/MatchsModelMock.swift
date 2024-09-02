//
//  MatchsModelMock.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import Foundation
@testable import CSTV

struct MatchsModelMock {
    static func makeMatch(
        id: Int? = 1,
        name: String? = "MatchName",
        beginAt: String? = "2024-09-01T23:30:00Z",
        matchID: String? = "match_id_123",
        opponents: [MatchsModel.OpponentsDictionary] = [OpponentsDictionaryMock.makeOpponent()],
        currentGame: MatchsModel.VideoGameName? = VideoGameNameMock.makeVideoGameName(),
        results: [MatchsModel.ResultsDictionary]? = [ResultsDictionaryMock.makeResult()],
        league: MatchsModel.League? = LeagueMock.makeLeague(),
        live: MatchsModel.MatchLive? = nil,
        status: MatchsModel.MatchStatus = .not_started
    ) -> MatchsModel {
        return MatchsModel(
            id: id,
            name: name,
            beginAt: beginAt,
            matchID: matchID,
            opponents: opponents,
            currentGame: currentGame,
            results: results,
            league: league,
            live: live,
            status: status
        )
    }

    struct OpponentsDictionaryMock {
        static func makeOpponent(team: MatchsModel.TeamDictionary = TeamDictionaryMock.makeTeam()) -> MatchsModel.OpponentsDictionary {
            return MatchsModel.OpponentsDictionary(team: team)
        }
    }

    struct ResultsDictionaryMock {
        static func makeResult(teamID: Int = 1, score: Int = 0) -> MatchsModel.ResultsDictionary {
            return MatchsModel.ResultsDictionary(teamID: teamID, score: score)
        }
    }

    struct VideoGameNameMock {
        static func makeVideoGameName(name: String = "Video Game Name") -> MatchsModel.VideoGameName {
            return MatchsModel.VideoGameName(name: name)
        }
    }

    struct TeamDictionaryMock {
        static func makeTeam(id: Int? = 1, name: String = "TeamName", acronym: String? = "TN", imageUrl: String? = "https://example.com/team.png") -> MatchsModel.TeamDictionary {
            return MatchsModel.TeamDictionary(
                id: id,
                name: name,
                acronym: acronym,
                imageUrl: imageUrl
            )
        }
    }

    struct LeagueMock {
        static func makeLeague(
            id: Int = 1,
            image_url: String? = "https://example.com/league.png",
            modified_at: String? = "2024-09-01T23:30:00Z",
            name: String = "League Name",
            slug: String = "league-name",
            url: String? = "https://example.com/league"
        ) -> MatchsModel.League {
            return MatchsModel.League(
                id: id,
                image_url: image_url,
                modified_at: modified_at,
                name: name,
                slug: slug,
                url: url
            )
        }
    }

}
