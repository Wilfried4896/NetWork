//
//  PhotosCollectionViewCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 17.06.2022.
//

import UIKit
import StorageService
import iOSIntPackage
 

class PhotosCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "PhotosCollectionViewCell"

    private lazy var galeryAlbum: UIImageView = {
        let galery = UIImageView()
        galery.clipsToBounds = true
        galery.translatesAutoresizingMaskIntoConstraints = false
        return galery
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpGalary()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpGalary() {
        addSubview(galeryAlbum)

        NSLayoutConstraint.activate([
            galeryAlbum.topAnchor.constraint(equalTo: topAnchor),
            galeryAlbum.leadingAnchor.constraint(equalTo: leadingAnchor),
            galeryAlbum.trailingAnchor.constraint(equalTo: trailingAnchor),
            galeryAlbum.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setUpPhoto(photo: UIImage) {
        galeryAlbum.image = photo
    }
}
