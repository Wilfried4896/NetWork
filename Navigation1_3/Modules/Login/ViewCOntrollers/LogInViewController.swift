//
//  LogInViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 11.06.2022.
//

import UIKit

enum ApiError: Error {
    case loginError
}

extension ApiError: CustomStringConvertible {
    var description: String {
        switch self {
        case.loginError:
            return "Логин или пароль некорректен"
        }
    }
}

class LogInViewController: UIViewController {

    var loginDelegate: LoginFactory?
    var viewModel: LoginNavigation?
    
    private lazy var scrollViewLogin: UIScrollView = {
        let scrollLogin = UIScrollView()
        scrollLogin.translatesAutoresizingMaskIntoConstraints = false
        return scrollLogin
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
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
        email.placeholder = "Email of phone"
        email.keyboardType = .emailAddress
        return email
    }()

    private lazy var passwordLogin: UITextField = {
        let password = parametrTextField()
        password.tag = 1
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        return password
    }()

    private lazy var logInButton: CustomButton = {
        let logIn = CustomButton(title: "Log In",bgColor: UIColor(patternImage: UIImage(named: "blue_pixel")!) ,tilteColor: .white)
        logIn.layer.cornerRadius = 10
        
        return logIn
    }()
    
    private lazy var buttonGetPassword: CustomButton = {
        let getPassword = CustomButton(title: "Подобрать пароль", bgColor: .systemBlue, tilteColor: .white)
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
        view.backgroundColor = .white
        view.addSubview(scrollViewLogin)
        scrollViewLogin.addSubview(contentView)
        
        contentView.addSubview(logoVk)
        contentView.addSubview(emailLogin)
        contentView.addSubview(passwordLogin)
        contentView.addSubview(logInButton)
        //contentView.addSubview(logoVk)

        actionButton()
        self.navigationController?.navigationBar.isHidden = true
        let area = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // scrollViewLoginConstraint
            scrollViewLogin.topAnchor.constraint(equalTo:  area.topAnchor),
            scrollViewLogin.leadingAnchor.constraint(equalTo: area.leadingAnchor),
            scrollViewLogin.trailingAnchor.constraint(equalTo: area.trailingAnchor),
            scrollViewLogin.bottomAnchor.constraint(equalTo: area.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollViewLogin.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollViewLogin.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollViewLogin.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollViewLogin.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollViewLogin.widthAnchor),
            
            // logoVkConstraints
            logoVk.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoVk.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoVk.heightAnchor.constraint(equalToConstant: 100),
            logoVk.widthAnchor.constraint(equalToConstant: 100),

            // emailLoginConstraints
            emailLogin.topAnchor.constraint(equalTo: logoVk.bottomAnchor, constant: 120),
            emailLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLogin.heightAnchor.constraint(equalToConstant: 50),

            // passwordLoginConstraints
            passwordLogin.topAnchor.constraint(equalTo: emailLogin.bottomAnchor),
            passwordLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordLogin.heightAnchor.constraint(equalToConstant: 50),
            
            // activityIndicator

//            activityIndicator.centerYAnchor.constraint(equalTo: passwordLogin.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: passwordLogin.centerXAnchor),

            // logInButtonConstraints
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: passwordLogin.bottomAnchor, constant: 16),
            
            // buttonGetPassword
/*            buttonGetPassword.heightAnchor.constraint(equalToConstant: 50),
            buttonGetPassword.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonGetPassword.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonGetPassword.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
*/
        ])
    }
    
    func parametrTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        //textField.textColor = UIColor.black
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

            self.scrollViewLogin.contentOffset = CGPoint(x: 0, y: yOffet)
        }
    }

    @objc func didHidekeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }

    @objc func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollViewLogin.contentOffset = CGPoint(x: 0, y: 0)
    }

    func loadUser(_ emailLogin: String, _ passwordLogin: String) throws {
        
        let loginInspector = self.loginDelegate?.makeLoginInspector()
        let verifiedCurrent = loginInspector?.check(loginUser: emailLogin, passwordUser: passwordLogin)
        
        guard let verifiedCurrent else { return }
        guard verifiedCurrent else {
            throw ApiError.loginError
        }
        self.viewModel?.goToHome()
    }
    
    private func actionButton() {
        logInButton.actionButton = {
            
            guard let emailLogin = self.emailLogin.text, let passwordLogin = self.passwordLogin.text else { return }
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                do {
                    try self.loadUser(emailLogin, passwordLogin)
                } catch {
                    if let error = error as? ApiError {
                        let messageError = UIAlertController(title: "Внимание", message: error.description, preferredStyle: .actionSheet)
                        let actionMessage = UIAlertAction(title: "OK", style: .destructive)
                        
                        messageError.addAction(actionMessage)
                        self.present(messageError, animated: true)
                    }
                }
            }
        }
        
        buttonGetPassword.actionButton = {
            
            self.passwordLogin.text = "1!ggsdfgdsfg3"
            self.passwordLogin.isSecureTextEntry = false
            
            let quere = DispatchQueue(label: "ru.Wifried4896", attributes: .concurrent)
            
            let workItem = DispatchWorkItem() {
                bruteForce(passwordToUnlock: "1!ggsdfgdsfg3")
            }
            
            let notifyItem = DispatchWorkItem() {
                self.activityIndicator.stopAnimating()
                self.passwordLogin.isSecureTextEntry = true
            }
            
            workItem.notify(queue: .main, execute: notifyItem)
            
            self.activityIndicator.startAnimating()
            quere.async(execute: workItem)
            
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
