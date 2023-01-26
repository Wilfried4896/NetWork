//
//  FeedModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.10.2022.
//

import Foundation

protocol Chech {
    func check(_ word: String) -> Bool
}

class FeedModel: Chech {
    
    var secretWord = "secretWord"
    
    func check(_ word: String) -> Bool {
        return word == secretWord
    }

}

