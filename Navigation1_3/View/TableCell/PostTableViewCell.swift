//
//  PostTableViewCell.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 14.06.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {

    private lazy var stackViewLikesViews: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 20, weight: .bold)
        //author.textColor = .black
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints = false
        return author
    }()

    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 14)
        description.textColor = .systemGray
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    lazy var imageArticle: UIImageView = {
        let avatare = UIImageView()
        avatare.contentMode = .scaleAspectFit
        avatare.backgroundColor = .black
        avatare.translatesAutoresizingMaskIntoConstraints = false
        return avatare
    }()

    private lazy var likesLabel: UILabel = {
        let likes = likesViewsDescrption()
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    private lazy var viewsLabel: UILabel = {
        let views = likesViewsDescrption()
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.descriptionLabel.text = nil
        self.imageArticle.image = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }

    private func setUpView() {
        [likesLabel, viewsLabel].forEach({
            stackViewLikesViews.addArrangedSubview($0)
        })

        [authorLabel, imageArticle, descriptionLabel, stackViewLikesViews].forEach({
            contentView.addSubview($0)
        })

        NSLayoutConstraint.activate([
            // authorLabelContraints
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // imageArticleContraints
            imageArticle.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            imageArticle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageArticle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageArticle.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            // descriptionLabelContraints
            descriptionLabel.topAnchor.constraint(equalTo: imageArticle.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // stackViewLikesViewsContraints
            stackViewLikesViews.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            stackViewLikesViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackViewLikesViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackViewLikesViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func likesViewsDescrption() -> UILabel {
        let likesViews = UILabel()
        likesViews.font = .systemFont(ofSize: 16)
        //likesViews.textColor = .black
        return likesViews
    }

    func setUp(with article: Article) {
        self.authorLabel.text = article.author
        self.imageArticle.image = UIImage(named: "\(article.image ?? "placeholder")")
        self.descriptionLabel.text = article.description
        self.likesLabel.text = String("Likes: \(article.likes)")
        self.viewsLabel.text = String("Views: \(article.views)")
    }
}
