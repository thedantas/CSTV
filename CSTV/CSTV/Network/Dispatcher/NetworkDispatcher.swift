//
//  NetworkDispatcher.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation

public typealias NetworkDispatcherCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkDispatcher: AnyObject {
    associatedtype EndPoint: EndPointType

    func request(_ route: EndPoint, completion: @escaping NetworkDispatcherCompletion)
    func cancel()
}

