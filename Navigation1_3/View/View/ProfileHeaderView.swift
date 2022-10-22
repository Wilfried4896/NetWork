//
//  ProfileHeaderView.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 06.06.2022.
//

import UIKit
import StorageService

class ProfileHeaderView: UITableViewHeaderFooterView {

    private var statusText: String?

    private lazy var avatarImageView: UIImageView = {
        let imageProfile = UIImageView()
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.layer.cornerRadius = 60
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.borderWidth = 3
        imageProfile.layer.borderColor = UIColor.white.cgColor

        return imageProfile
    }()

    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        //name.textColor = .black
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false

        return name
    }()

    private lazy var setStatusButton: CustomButton = {
        let show = CustomButton(title: "Set status", bgColor: .systemBlue, tilteColor: .white)
        
        show.layer.cornerRadius = 10
        show.layer.shadowRadius = 4
        show.layer.borderColor = UIColor.black.cgColor
        show.layer.shadowOpacity = 0.7
        show.layer.shadowOffset = CGSize(width: 4, height: 4)

        return show
    }()

    private lazy var statusTextField: UITextField = {
        let textFiel = UITextField()
        textFiel.font = .systemFont(ofSize: 15, weight: .regular)
        textFiel.textColor = .black
        textFiel.backgroundColor = .white
        textFiel.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textFiel.translatesAutoresizingMaskIntoConstraints = false
        textFiel.layer.borderColor = UIColor.black.cgColor
        textFiel.layer.borderWidth = 1
        textFiel.layer.cornerRadius = 10
        textFiel.placeholder = "Set your status"
        textFiel.delegate = self

        return textFiel
    }()

    lazy var statusLabel: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false

        return text
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        [avatarImageView, fullNameLabel, setStatusButton, statusLabel, statusTextField].forEach({
           addSubview($0)
        })
        
        actionButtonsetStatus()
        
        NSLayoutConstraint.activate([
            // avatarImageViewConstraint
            self.avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 120),

            // fullNameLabelConstraint
            self.fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            self.fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 13),

            // statusLabelConstraint
            self.statusLabel.bottomAnchor.constraint(equalTo: self.setStatusButton.topAnchor, constant: -55),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 13),
            self.statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            // statusTextFieldConstraint
            self.statusTextField.bottomAnchor.constraint(equalTo: self.setStatusButton.topAnchor, constant: -10),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 13),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            // setStatusButtonConstraint
            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16),
            self.setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configurationProfile(profile: User) {
        avatarImageView.image = profile.avatar
        fullNameLabel.text = profile.fullName
        statusLabel.text = profile.status
    }
    
    @objc func statusTextChanged(_textField: UITextField) {
        statusText = _textField.text
    }
    
    private func actionButtonsetStatus() {
        setStatusButton.actionButton = {
            guard let statusText = self.statusText else {
                self.statusLabel.text = "Нет статуса"
                return
            }
            self.statusLabel.text = statusText
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
}

