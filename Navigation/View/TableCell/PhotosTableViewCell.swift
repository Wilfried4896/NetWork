//
//  PhotosTableViewCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 17.06.2022.
//

import UIKit
import StorageService

class PhotosTableViewCell: UITableViewCell {

    private let photoGameOfThrone: [PhotoGame] = Photo.shared.imageData
    
    private enum Constants {
        static let numberInItem: CGFloat = 3
    }

    private lazy var photoLabel: UILabel = {
        let tilte = UILabel()
        tilte.text = "photoLabel".localized
        tilte.font = .systemFont(ofSize: 24, weight: .bold)
        tilte.textColor = UIColor.createColor(lightMode: UIColor.label, darkMode: .white)
        tilte.translatesAutoresizingMaskIntoConstraints = false
        return tilte
    }()

    private lazy var arrowButton: UIButton = {
        let arrow = UIButton()
        arrow.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.addTarget(self, action: #selector(photoAlbum), for: .touchUpInside)
        return arrow
    }()

    private lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        layout.minimumInteritemSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MyCostumCollectionCell.self, forCellWithReuseIdentifier: "MyCostumCollectionCell")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        //self.backgroundColor = .white
        [photoLabel, arrowButton, photoCollection].forEach({
            contentView.addSubview($0)
        })

        NSLayoutConstraint.activate([
            // photoLabelConstraint
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            // arrowImageConstraint
            arrowButton.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            // photoCollectionConstraint
            photoCollection.topAnchor.constraint(equalTo: photoLabel.bottomAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    @objc func photoAlbum() {
        
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellPhoto = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCostumCollectionCell", for: indexPath) as? MyCostumCollectionCell else {
            let cellDefault = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return cellDefault
        }

        let photo = photoGameOfThrone[indexPath.row]
        cellPhoto.setUpPhoto(with: photo)
        return cellPhoto
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
       // let inset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero

        let needWidth = (collectionView.frame.width - Constants.numberInItem * spacing) / 4
        return CGSize(width: needWidth, height: needWidth)
    }
}
