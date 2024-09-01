//
//  Services.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import RxSwift

struct Services {

    func fetchAllMatches(page: Int) -> Single<[MatchsModel]> {
        if page == 1  {
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
   
    func fetchRunningMatches() -> Single<[MatchsModel]> {
        return Single.create { single in
            manager.dispatcher.request(.runningMatches) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(SwiftyRestKitError.decodingFailed))
                    return
                }

                let result = manager.handleNetworkResponse(httpResponse)

                switch result {
                case .Success:
                    do {
                        let decoder = JSONDecoder()
                        let matches = try decoder.decode([MatchsModel].self, from: data!)
                        single(.success(matches))
                    } catch {
                        single(.failure(SwiftyRestKitError.decodingFailed))
                    }

                case .Failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchUpcomingMatches(page: Int) -> Single<[MatchsModel]> {
        return Single.create { single in
            manager.dispatcher.request(.upcomingMatches(page: page)) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(SwiftyRestKitError.decodingFailed))
                    return
                }

                let result = manager.handleNetworkResponse(httpResponse)

                switch result {
                case .Success:
                    do {
                        let decoder = JSONDecoder()
                        let matches = try decoder.decode([MatchsModel].self, from: data!)
                        single(.success(matches))
                    } catch {
                        single(.failure(SwiftyRestKitError.decodingFailed))
                    }

                case .Failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchTeam(teamID: Int) -> Single<Team> {
        return Single.create { single in
            manager.dispatcher.request(.showDetails(teamID: teamID)) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(SwiftyRestKitError.decodingFailed))
                    return
                }

                let result = manager.handleNetworkResponse(httpResponse)

                switch result {
                case .Success:
                    do {
                        let decoder = JSONDecoder()
                        let teamData = try decoder.decode(Team.self, from: data!)
                        single(.success(teamData))
                    } catch {
                        single(.failure(SwiftyRestKitError.decodingFailed))
                    }

                case .Failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

extension Services: Service {
    typealias EndPoint = CSAPI
}

extension Services: Gettable { }


