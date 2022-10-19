//
//  InfoViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.06.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray3
        self.navigationItem.title = "Информация"
        self.view.addSubview(buttonConfirmation)
    }

    lazy var buttonConfirmation: CustomButton = {
        
        let buttonConfirmation = CustomButton(title: "Выйти", bgColor: .black, tilteColor: .white)
       
        buttonConfirmation.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        buttonConfirmation.center = self.view.center
        buttonConfirmation.layer.cornerRadius = 10
        buttonConfirmation.actionButton = {
            
            let alertController = UIAlertController(title: "Выйти из этой страницы", message: "Хотите выйти ?", preferredStyle: .alert)

            let cancelButton = UIAlertAction(title: "Да", style: .cancel) { _ in
                self.dismiss(animated: true)
                print("Вышел")
            }
            alertController.addAction(cancelButton)

            let okButton = UIAlertAction(title: "Нет", style: .destructive) { _ in
                print("Еще не зокнчил")
            }
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }
        
        return buttonConfirmation
    }()
}
