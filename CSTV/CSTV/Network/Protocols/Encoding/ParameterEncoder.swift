//
//  ParameterEncoder.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

