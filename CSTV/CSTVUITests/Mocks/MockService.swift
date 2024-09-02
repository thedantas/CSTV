//
//  MockService.swift
//  CSTVUITests
//
//  Created by André  Costa Dantas on 01/09/24.
//

import Foundation
import RxSwift

@testable import CSTV

import Foundation
import RxSwift

class MockService: Gettable {
    // Propriedades para armazenar os resultados simulados
    var fetchAllMatchesResult: Single<[MatchsModel]>?
    var fetchRunningMatchesResult: Single<[MatchsModel]>?
    var fetchUpcomingMatchesResult: Single<[MatchsModel]>?
    var fetchTeamResult: Single<Team>?

    // Inicializador padrão
    init() {}

    // Método para simular `fetchAllMatches`
    func fetchAllMatches(page: Int) -> Single<[MatchsModel]> {
        // Se o resultado simulado estiver definido, retorne-o
        if let result = fetchAllMatchesResult {
            return result
        }

        // Comportamento padrão: simula combinação de runningMatches e upcomingMatches
        if page == 1 {
            return Single.zip(
                fetchRunningMatches(),
                fetchUpcomingMatches(page: page)
            ).map { runningMatches, upcomingMatches in
                return runningMatches + upcomingMatches
            }
        } else {
            return fetchUpcomingMatches(page: page)
        }
    }

    // Método para simular `fetchRunningMatches`
    func fetchRunningMatches() -> Single<[MatchsModel]> {
        // Retorna o resultado simulado ou um observable que nunca emite nada
        return fetchRunningMatchesResult ?? .never()
    }

    // Método para simular `fetchUpcomingMatches`
    func fetchUpcomingMatches(page: Int) -> Single<[MatchsModel]> {
        // Retorna o resultado simulado ou um observable que nunca emite nada
        return fetchUpcomingMatchesResult ?? .never()
    }

    // Método para simular `fetchTeam`
    func fetchTeam(teamID: Int) -> Single<Team> {
        // Retorna o resultado simulado ou um observable que nunca emite nada
        return fetchTeamResult ?? .never()
    }
}
