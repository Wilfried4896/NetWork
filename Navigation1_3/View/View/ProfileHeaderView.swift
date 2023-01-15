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
        let show = CustomButton(title: Localization.setStatusButton.rawValue~, bgColor: .systemBlue, tilteColor: .white)
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
        textFiel.placeholder = Localization.statusTextField.rawValue~
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
        contentView.addSubview(avatarImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        
        actionButtonsetStatus()
        
        NSLayoutConstraint.activate([
            // MARK: - avatarImageViewConstraint
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  16),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),

            // MARK: - fullNameLabelConstraint
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 13),

            // MARK: - statusLabelConstraint
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -55),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 13),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // MARK: - statusTextFieldConstraint
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -10),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 13),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // MARK: - setStatusButtonConstraint
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configurationProfile(profile: User) {
        avatarImageView.image = profile.avatar
        statusLabel.text = profile.status
        
    }
    
    @objc func statusTextChanged(_textField: UITextField) {
        statusText = _textField.text
    }
    
    private func actionButtonsetStatus() {
        setStatusButton.actionButton = {
            guard let statusText = self.statusText else {
                self.statusLabel.text = Localization.actionButtonsetStatus.rawValue~
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

