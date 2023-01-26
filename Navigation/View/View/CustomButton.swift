//
//  CustomButton.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 01.10.2022.
//

import UIKit

class CustomButton: UIButton {
    
    var actionButton: (() -> Void)?
    
    convenience init(title: String? = nil, bgColor: UIColor? = nil, tilteColor: UIColor? = nil, type: UIButton.ButtonType = .system ) {
       
        self.init(type: type)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        setTitleColor(tilteColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped() {
        actionButton?()
    }
}
