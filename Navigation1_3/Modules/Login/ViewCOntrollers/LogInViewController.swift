//
//  LogInViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 11.06.2022.
//

import UIKit
import FirebaseAuth
import RealmSwift

enum ApiError: Error {
    case loginError
}

class LogInViewController: UIViewController {

    var loginDelegate: LoginViewControllerDelegate?
    var viewModel: LoginViewModel?
    let realm = try! Realm()
    
    var serviceDelegate: ServiceProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()


    private lazy var logoVk: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private lazy var emailLogin: UITextField = {
        let email = parametrTextField()
        email.tag = 0
        email.placeholder = "emailLogin_placeholder".localized
        email.keyboardType = .emailAddress
        return email
    }()

    private lazy var passwordLogin: UITextField = {
        let password = parametrTextField()
        password.tag = 1
        password.placeholder = "passwordLogin_placeholder".localized
        password.isSecureTextEntry = true
        return password
    }()

    private lazy var logInButton: CustomButton = {
        let logIn = CustomButton(title: "logInButton_title".localized ,bgColor: UIColor.createColor(lightMode: UIColor(patternImage: UIImage(named: "blue_pixel")!), darkMode: .systemGray3) ,tilteColor: .white)
        logIn.layer.cornerRadius = 10
        return logIn
    }()
    
    private lazy var buttonGetPassword: CustomButton = {
        let getPassword = CustomButton(title: "buttonGetPassword_title".localized, bgColor: .systemBlue, tilteColor: .white)
        getPassword.layer.cornerRadius = 10
        return getPassword
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = UIColor(patternImage: UIImage(named: "blue_pixel")!)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLogInView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(self.didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didHidekeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func setUpLogInView() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        scrollView.addSubview(logoVk)
        scrollView.addSubview(emailLogin)
        scrollView.addSubview(passwordLogin)
        scrollView.addSubview(logInButton)

        
        actionButton()
        //self.logInButton.isHidden = true
        navigationController?.navigationBar.isHidden = true
        let area = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - scrollViewLoginConstraint
            scrollView.topAnchor.constraint(equalTo:  area.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: area.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: area.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: area.bottomAnchor),
            
            // MARK: - logoVkConstraints
            logoVk.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoVk.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoVk.heightAnchor.constraint(equalToConstant: 100),
            logoVk.widthAnchor.constraint(equalToConstant: 100),

            //MARK: - emailLoginConstraints
            emailLogin.topAnchor.constraint(equalTo: logoVk.bottomAnchor, constant: 120),
            emailLogin.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            emailLogin.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            emailLogin.heightAnchor.constraint(equalToConstant: 50),

            //MARK: - passwordLoginConstraints
            passwordLogin.topAnchor.constraint(equalTo: emailLogin.bottomAnchor),
            passwordLogin.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            passwordLogin.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            passwordLogin.heightAnchor.constraint(equalToConstant: 50),

            //MARK: - logInButtonConstraints
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: passwordLogin.bottomAnchor, constant: 16),
        ])

    }
    
    func parametrTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.createColor(lightMode: UIColor.lightGray, darkMode: .white).cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = UIColor.systemGray6
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    @objc func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let logInButtonPositionY = self.logInButton.frame.origin.y + self.logInButton.frame.height + self.view.safeAreaInsets.top
            let keyboardOriginY = self.view.frame.height - keyboardHeight

            let yOffet = keyboardOriginY < logInButtonPositionY ? logInButtonPositionY - keyboardOriginY + 15 : 0

            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffet)
        }
    }

    @objc func didHidekeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }

    @objc func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func ShowAlert(_ title: String, _ message: String) {
        let messageError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        messageError.addAction(UIAlertAction(title: "ShowAlert_UIAlertAction_title".localized, style: .destructive))
        present(messageError, animated: true)
    }
    
    private func actionButton() {
        logInButton.actionButton = {

            guard let email = self.emailLogin.text, !email.isEmpty,
                    let password = self.passwordLogin.text, !password.isEmpty else {
                self.ShowAlert("logInButton_actionButton_error_title".localized, "logInButton_actionButton_error_message".localized)
                return
            }
            
            // MARK: - FireBaseAuth
            self.loginDelegate?.checkCredentials(email, password, { auth in
                switch auth {
                case .success(_):
                    // MARK: - RealmSwift
                    self.viewModel?.goToHome()
                case .failure(let error):
                    switch error.code {
                    case .userNotFound:
                        let message = UIAlertController(title: "message_alert_title".localized, message: "message_alert_message".localized, preferredStyle: .alert)
                        message.addAction(UIAlertAction(title: "message_destructive_title".localized, style: .destructive) {_ in
                            self.loginDelegate?.signUp(email, password)
                            self.serviceDelegate?.saveAuth(email, password)
                            self.viewModel?.goToHome()
                        })
                        
                        message.addAction(UIAlertAction(title: "message_cancel_title".localized, style: .cancel))
                        self.present(message, animated: true)
                    default:
                        self.ShowAlert("ShowAlert_RealmSwift".localized, "\(error.localizedDescription)")
                    }
                }
            })
        }

    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
