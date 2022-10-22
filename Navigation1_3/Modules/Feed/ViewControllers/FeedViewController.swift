//
//  FeedViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.06.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    var post = PostFeed(Title: "Мой пост")
    
    var feedViewModel = FeedViewModel()
    weak var coordinator: FeedCoordinator?
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Проверить", bgColor: .black, tilteColor: .white)
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var textFielFeed: CustomTextField = {
        let textField = CustomTextField(placeholderTitle: "Enter the secret code")
        textField.delegate = self
        return textField
    }()
    
    private lazy var infoBotton: UIBarButtonItem = {
        let info = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapped))
        return info
    }()
    
    private lazy var statusFeedLabel: UILabel = {
        let statusFeed = UILabel()
        statusFeed.translatesAutoresizingMaskIntoConstraints = false
        return statusFeed
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Лента"
        view.backgroundColor = .white
        setUpStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false

    }

    private func setUpStackView() {
        view.addSubview(textFielFeed)
        view.addSubview(checkGuessButton)
        view.addSubview(statusFeedLabel)
        //binding()
        checkGuessButtonVerification()
        
        navigationItem.rightBarButtonItem = infoBotton
        
        NSLayoutConstraint.activate([
            textFielFeed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textFielFeed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textFielFeed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textFielFeed.heightAnchor.constraint(equalToConstant: 50),
            
            
            checkGuessButton.topAnchor.constraint(equalTo: textFielFeed.bottomAnchor, constant: 30),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusFeedLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            statusFeedLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func alert(_ title: String, _ message: String) {
        let messageError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionMessage = UIAlertAction(title: "OK", style: .destructive)
        
        messageError.addAction(actionMessage)
        self.present(messageError, animated: true)
    }
    
    @objc private func didTapped() {
        coordinator?.goToInfo()
    }

    private func checkGuessButtonVerification() {
        checkGuessButton.actionButton = {
            
            guard let textFielFeed = self.textFielFeed.text else { return }

            switch self.feedViewModel.didTapButton(textFielFeed) {
                case .success(let succes):
                    self.alert("Браво", succes)
                case.failure(let error):
                    self.alert("🧐🧐🧐", error.description)
            }
        }
    }
}

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
