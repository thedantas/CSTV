//
//  NibLoadableView.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

public protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {

    public static var NibName: String {
        return String(describing: self)
    }
}
