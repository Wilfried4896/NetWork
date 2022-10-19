//
//  CsutomTextField.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.10.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    convenience init(placeholderTitle: String? = nil) {
        self.init()
        
        placeholder = placeholderTitle
        clearButtonMode = .whileEditing
        layer.borderColor = UIColor.systemGray.cgColor
        font = .systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

