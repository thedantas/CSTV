//
//  UINavigationBar+Helpers.swift
//  CSTV
//
//  Created by André  Costa Dantas on 27/08/24.
//

import Foundation
import UIKit

extension UINavigationBar {
    func setPrimaryLargeTitleAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .heavyPurpleColor
        standardAppearance = navBarAppearance
        scrollEdgeAppearance = navBarAppearance
    }
}
extension UIViewController {

    func setBackButton(){
        let yourBackImage = UIImage(named: "ic-arrow-left")
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }

}
