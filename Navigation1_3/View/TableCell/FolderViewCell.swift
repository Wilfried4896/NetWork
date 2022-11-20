//
//  FolderViewCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 20.11.2022.
//

import UIKit

class FolderViewCell: UITableViewCell {

    lazy var nameArticle: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var imageArticle: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var detailsArticle: UILabel = {
        let details = UILabel()
        details.numberOfLines = 0
        details.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        details.tintColor = .systemGray4
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurationContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationContentView() {
        contentView.addSubview(nameArticle)
        contentView.addSubview(imageArticle)
        contentView.addSubview(detailsArticle)
        
        NSLayoutConstraint.activate([
            nameArticle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameArticle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameArticle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            imageArticle.topAnchor.constraint(equalTo: nameArticle.bottomAnchor, constant: 10),
            imageArticle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageArticle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageArticle.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            detailsArticle.topAnchor.constraint(equalTo: imageArticle.bottomAnchor, constant: 10),
            detailsArticle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            detailsArticle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            detailsArticle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configurationCell(_ folder: Folder) {
        nameArticle.text = folder.name
        detailsArticle.text = folder.detail
        guard let image = folder.image else {
            imageArticle.image = UIImage(systemName: "photo.artframe")
            return
        }
        imageArticle.image = UIImage(data: image)
    }
}

