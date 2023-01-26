//
//  LocalizationShow.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 15.01.2023.
//

import Foundation

postfix operator ~
postfix func ~ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}


public func locationDic (string: String, namePlanet: String, dayNumber: Int) -> String {
    
    let formatter = NSLocalizedString(string, comment: "")
    return String(format: formatter, namePlanet, dayNumber)
}
