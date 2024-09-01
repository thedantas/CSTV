//
//  HTTPTask.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

public typealias HTTPHeader = [String : String]

public enum HTTPTask {
    case request
    case requestWith(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestWithHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeader?)

}
