//
//  CSAPI.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

enum CSAPI {
    case runningMatches
    case upcomingMatches(page: Int)
    case showDetails(teamID: Int)
}

extension CSAPI: EndPointType {
    var apiClientKey: String? {
        return nil
    }

    var apiClientSecret: String? {
        return nil
    }

    var baseURLString: String {
        return "https://api.pandascore.co/"
    }

    var token: String {
        return "DMti044ZXthhIDy4cVnzkrpmwEjNoqvJzCW1RCyeISxY6WwOrxE"
    }

    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .runningMatches:
            return "csgo/matches/running"
        case .upcomingMatches:
            return "csgo/matches/upcoming"
        case .showDetails(let teamID):
            return "teams/\(teamID)"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .runningMatches:
            return .requestWithHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        case .upcomingMatches(let page):
            let urlParameters: Parameters = ["page": page]
            return .requestWithHeaders(bodyParameters: nil, urlParameters: urlParameters, additionalHeaders: headers)
        case .showDetails(let teamID):
            let urlParameters: Parameters = ["teams": teamID]
            return .requestWithHeaders(bodyParameters: nil, urlParameters: urlParameters, additionalHeaders: headers)
        }
    }

    var headers: HTTPHeader? {
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
