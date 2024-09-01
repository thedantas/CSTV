//
//  InternalError.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

enum InternalError: Error {
    case decodingError
    case noDataError
    case urlBuildingError
    case validationError
    case unknownError
}
