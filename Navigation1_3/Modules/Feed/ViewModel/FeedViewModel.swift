//
//  FeedViewModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import Foundation

enum WordError: Error {
    case noFoundWord
    case emptyFields
}

extension WordError: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyFields:
            return "Пустой поль"
        case .noFoundWord:
            return "Неправильно"
        }
    }
}
protocol FeedViewModelProtocol {
    var text: Binding<String> { get set }
    func goToInfo()
}

class FeedViewModel: FeedViewModelProtocol {
    
    var text = Binding<String>("")
    //var color = Binding<UIColor>(.white)
    
    let feedModel = FeedModel()
     private var isCorrect = false

    
    func didTapButton(_ word: String) -> Result<String, WordError> {
        isCorrect = feedModel.check(word)
        
        guard isCorrect else {
            //text.value = "Неправильно"
            //color.value = .red
            return .failure(.noFoundWord)
        }
        //text.value = "Правильно"
        //color.value = .green
        return .success("Правильно")
    }
    
    func goToInfo() {
        
    }
}
