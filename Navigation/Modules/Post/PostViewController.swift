//
//  PostViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.06.2022.
//

import UIKit

class PostViewController: UIViewController {

    var titlePost: String?

    lazy var buttonBarItem: UIBarButtonItem = {
        let buttonBarItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(moreInformation))

        return buttonBarItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = buttonBarItem
        setUpView()
    }

    func setUpView() {
        self.view.backgroundColor = UIColor.systemGray5
        self.navigationItem.title = titlePost
    }

    @objc func moreInformation() {
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        present(infoViewController, animated: true, completion: nil)
    }
}
