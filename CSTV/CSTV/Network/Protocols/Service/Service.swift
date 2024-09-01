//
//  Service.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

public protocol Service {
    associatedtype EndPoint: EndPointType
}

extension Service {
    public var manager: NetworkManager<EndPoint> {
        return NetworkManager<EndPoint>()
    }

}
