//
//  LogInViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 11.06.2022.
//

import UIKit
import FirebaseAuth

enum ApiError: String, Error {
    case loginError = "Логин или пароль некорректен"
}

public func showMessage() {
    
}

class LogInViewController: UIViewController {

    var loginDelegate: LoginViewControllerDelegate?
    var viewModel: LoginViewModel?
    
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
            // scrollViewLoginConstraint
            scrollView.topAnchor.constraint(equalTo:  area.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: area.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: area.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: area.bottomAnchor),
            
            // logoVkConstraints
            logoVk.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoVk.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoVk.heightAnchor.constraint(equalToConstant: 100),
            logoVk.widthAnchor.constraint(equalToConstant: 100),

            // emailLoginConstraints
            emailLogin.topAnchor.constraint(equalTo: logoVk.bottomAnchor, constant: 120),
            emailLogin.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            emailLogin.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            emailLogin.heightAnchor.constraint(equalToConstant: 50),

            // passwordLoginConstraints
            passwordLogin.topAnchor.constraint(equalTo: emailLogin.bottomAnchor),
            passwordLogin.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            passwordLogin.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            passwordLogin.heightAnchor.constraint(equalToConstant: 50),

            // logInButtonConstraints
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: passwordLogin.bottomAnchor, constant: 16),
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

//    func loadUser(_ emailLogin: String, _ passwordLogin: String) throws {
//
//        let loginInspector = self.loginDelegate?.makeLoginInspector()
//        let verifiedCurrent = loginInspector?.check(loginUser: emailLogin, passwordUser: passwordLogin)
//
//        guard let verifiedCurrent, verifiedCurrent else {
//            throw ApiError.loginError
//        }
//
//        self.viewModel?.goToHome()
//    }
    
    func ShowAlert(_ title: String, _ message: String) {
        let messageError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        messageError.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(messageError, animated: true)
    }
    
    private func actionButton() {
        logInButton.actionButton = {

            guard let email = self.emailLogin.text, !email.isEmpty,
                    let password = self.passwordLogin.text, !password.isEmpty else {
                self.ShowAlert("Error", "Email/Paasword пусой")
                return
            }
            
            self.loginDelegate?.checkCredentials(email, password, { auth in
                switch auth {
                case .success(_):
                    self.viewModel?.goToHome()
                case .failure(let error):
                    switch error.code {
                    case .userNotFound:
                        let message = UIAlertController(title: "Аккаунт не найден", message: "Хотите создать его", preferredStyle: .alert)
                        message.addAction(UIAlertAction(title: "Hовый аккаунт", style: .destructive) {_ in
                            self.loginDelegate?.signUp(email, password)
                            self.viewModel?.goToHome()
                        })
                        
                        message.addAction(UIAlertAction(title: "Отменить", style: .cancel))
                        self.present(message, animated: true)
                    default:
                        self.ShowAlert("Внимание", "\(error.localizedDescription)")
                    }
                }
            })
        }
        
/*        buttonGetPassword.actionButton = {
            
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
 */
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
