//
//  StoryboardIDHandlerType.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import UIKit
import Foundation


public protocol StoryboardIDHandlerType { }

extension StoryboardIDHandlerType where Self: UIViewController {

    public static var storyboardID: String {
        return String.init(describing: self)
    }
}
