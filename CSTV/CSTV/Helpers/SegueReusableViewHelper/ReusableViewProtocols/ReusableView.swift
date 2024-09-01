//
//  ReusableView.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {

    public static var reuseIdentifier: String {
        return String.init(describing: self)
    }
}
