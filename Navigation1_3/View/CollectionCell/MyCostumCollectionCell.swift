//
//  MyCostumCollectionCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 20.06.2022.
//

import UIKit
import StorageService

class MyCostumCollectionCell: UICollectionViewCell {

    lazy var photoImage: UIImageView = {
        let arrow = UIImageView()
        arrow.layer.cornerRadius = 8
        arrow.clipsToBounds = true
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        addSubview(photoImage)

        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setUpPhoto(with album: PhotoGame) {
        photoImage.image = UIImage(named: "\(album.image ?? "placeholder")")
    }
}
