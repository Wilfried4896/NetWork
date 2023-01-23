//
//  UIColorExtension.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 16.01.2023.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { traitCollection -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

extension UIViewController {

}

