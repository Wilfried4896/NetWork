//
//  SavedFileController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 20.11.2022.
//

import UIKit

class SavedFileController: UITableViewController {
    weak var coordiantor: SavedFileCoordinator?
    let coreDataManager = CoreDataMangement.shared
    
    var folder: [Folder] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.register(FolderViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folder = coreDataManager.realodFolder()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FolderViewCell
        let article = folder[indexPath.row]
        cell.configurationCell(article)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataManager.removeFolder(folder: folder[indexPath.row])
            folder.remove(at: indexPath.row)
        }
    }

}
