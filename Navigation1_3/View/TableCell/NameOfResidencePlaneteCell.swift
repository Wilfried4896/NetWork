//
//  NameOfResidencePlaneteCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 22.10.2022.
//

import UIKit

class NameOfResidencePlaneteCell: UITableViewCell {

    static let identifier: String = "NameOfResidencePlaneteCell"
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 20, weight: .semibold)
        name.tintColor = .systemGray3
        name.numberOfLines = 0
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        contentView.addSubview(nameLabel)
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
        ])
    }
}
