//
//  SegueHandlerType.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit
import Foundation

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController,
    SegueIdentifier.RawValue == String
{

    public func performSegue(withIdentifier segueIdentifier: SegueIdentifier,
                                    sender: Any?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }

    public func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {

            fatalError("Invalid segue identifier \(segue.identifier ?? "").")
        }
        return segueIdentifier
    }
}
