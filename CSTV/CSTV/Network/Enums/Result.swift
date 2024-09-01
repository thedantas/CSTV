//
//  Result.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

public enum Result<T: Decodable>  {
    case Success(T)
    case Failure(Error)
}
