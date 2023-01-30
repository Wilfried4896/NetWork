//
//  ProfileViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.06.2022.
//

import UIKit
import StorageService
import FirebaseAuth
import UniformTypeIdentifiers

class ProfileViewController: UIViewController {
    let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=55c8624285d94dcf975066f96611753a"
    var articleNet: [Articles] = [] {
        didSet {
            DispatchQueue.main.async {
                self.profileTableHederView.reloadData()
            }
        }
    }
    
    private var article: [Article] = Post.shared.data
    var userCurrent: User = User(login: "login", fullName: "Kali-Linux",
                                 avatar: UIImage(named: "fleur"), status: "userCurrent_status".localized)

    private lazy var profileTableHederView: UITableView = {
        let profileTable = UITableView(frame: .zero, style: .plain)
        profileTable.rowHeight = UITableView.automaticDimension
        profileTable.estimatedRowHeight = 20
        profileTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "Profile")
        profileTable.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        profileTable.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        profileTable.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        profileTable.translatesAutoresizingMaskIntoConstraints = false
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.dropDelegate = self
        profileTable.dragDelegate = self
        profileTable.dragInteractionEnabled = true
        profileTable.backgroundColor = .white
        return profileTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
   private func setUpView() {
       self.view.addSubview(profileTableHederView)
       navigationController?.navigationBar.barTintColor = UIColor.green
       let gesteTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
       gesteTap.numberOfTapsRequired = 2
       profileTableHederView.addGestureRecognizer(gesteTap)
       
       ProfileManagementNetwork.shared.reloadDataNetwork(urlString) { articles in
           switch articles {
           case .success(let article):
                for index in 0..<article.count {
                    self.articleNet = article[index].articles
               }
           case .failure(let error):
               switch error {
               case .noDataAvaible:
                   print("noDataAvaible_value".localized)
               case .invaliddURL:
                   print("invaliddURL_value".localized)
               case .dataNotFound:
                   print("dataNotFound_value".localized)
               case .noData:
                   print("noData_value".localized)
               }
           }
       }
       
        NSLayoutConstraint.activate([
            // MARK: -profileTableHederViewContraints
            profileTableHederView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableHederView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableHederView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableHederView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didDoubleTap() {
        guard let indexPath = profileTableHederView.indexPathForSelectedRow else { return }
        
        let nameArticle = articleNet[indexPath.row].author
        let detailArticle = articleNet[indexPath.row].description
        let imageArticle = articleNet[indexPath.row].urlToImage
        
        if let nameArticle, let detailArticle, let imageArticle {
            CoreDataMangement.shared.addFolder(nameArticle, imageArticle, detailArticle)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
            return article.count
            default:
                return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cellPhoto = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) 
                return cellPhoto

            case 1:
                guard let cellArticle = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                    return cell
                }
                let article = self.article[indexPath.row]
//                let article = articleNet[indexPath.row]
                cellArticle.setUp(with: article)
                return cellArticle

            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0:
            let user = Auth.auth().currentUser
            let profileHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Profile") as! ProfileHeaderView 
            tableView.backgroundColor = .systemGroupedBackground
            profileHeader.configurationProfile(profile: userCurrent)
            profileHeader.fullNameLabel.text = user?.email
            return profileHeader

            default:
                return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let photoView = PhotosViewController()
        navigationController?.pushViewController(photoView, animated: true)
    }
}

extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        var imagePost = UIImage()
        if let image = article[indexPath.row].image {
            imagePost = image
        } else {
            imagePost = UIImage(systemName: "house")!
        }
       // let imagePost = article[indexPath.row].image
        let descriptionPost = article[indexPath.row].description
        
        let itemProviderDes = NSItemProvider(item: descriptionPost.data(using: .utf8) as? NSData, typeIdentifier: UTType.plainText.identifier)
//        let itemProviderImg = NSItemProvider(item: imagePost, typeIdentifier: UTType.image.identifier)
        let itemProviderImg = NSItemProvider(object: imagePost)
        
        let drapDescr = UIDragItem(itemProvider: itemProviderDes)
        let drapImg = UIDragItem(itemProvider: itemProviderImg)
        
        return [drapImg, drapDescr]
    }

    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        
        _ = coordinator.session.loadObjects(ofClass: String.self) { item in
            if item.count > 0 {
                guard let description = item.first else { return }
                guard let imgRead: URL = URL(string: item[0]) else { return }
                print("\(imgRead) \n \(description)")
                self.article.insert(Article(author: "DrapDrop", image: UIImage(contentsOfFile: imgRead.path), description: description, likes: 0, views: 0), at: destinationIndexPath.row)
                self.profileTableHederView.reloadData()
            }
        }
    }
}
