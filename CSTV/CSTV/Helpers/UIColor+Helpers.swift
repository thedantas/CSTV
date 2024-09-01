//
//  UIColor+Helpers.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

extension UIColor {

    class var heavyPurpleColor: UIColor {
        guard let color = UIColor(named: "HeavyPurpleColor") else {
            return UIColor.purple
        }
        return color
    }

    class var lightPurpleColor: UIColor {
        guard let color = UIColor(named: "LightPurpleColor") else {
            return UIColor.lightGray
        }
        return color
    }

    class var accentColor: UIColor {
        guard let color = UIColor(named: "AccentColor") else {
            return UIColor.blue 
        }
        return color
    }

    class var randomColor: UIColor {
        let salmonColor = UIColor(r: 255, g: 95, b: 88)
        let orangeColor = UIColor(r: 250, g: 153, b: 23)
        let yellowColor = UIColor(r: 243, g: 202, b: 62)
        let greenColor = UIColor(r: 42, g: 201, b: 64)
        let lightBlueColor = UIColor(r: 51, g: 153, b: 255)
        let cyanColor = UIColor(r: 51, g: 225, b: 255)
        let pinkColor = UIColor(r: 255, g: 51, b: 102)
        let lightGrayColor = UIColor.lightGray
        let purpleColor = UIColor.purple
        let primaryRedColor = UIColor.heavyPurpleColor

        let colors = [salmonColor, orangeColor, yellowColor, greenColor, lightBlueColor, cyanColor, pinkColor, lightGrayColor, purpleColor, primaryRedColor]

        if let pickedColor = colors.randomElement() {
            return pickedColor
        }
        return UIColor.brown
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
