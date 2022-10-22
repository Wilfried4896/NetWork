//
//  InfoViewController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.06.2022.
//

import UIKit

class InfoViewController: UIViewController {

    weak var coordinator: FeedCoordinator?
    
    var nameHabitant = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableNameView.reloadData()
            }
        }
    }
    
    private lazy var tableNameView: UITableView = {
        let nameTable = UITableView(frame: .zero, style: .insetGrouped)
        nameTable.rowHeight = UITableView.automaticDimension
        nameTable.estimatedRowHeight = 20
        nameTable.register(NameOfResidencePlaneteCell.self, forCellReuseIdentifier: NameOfResidencePlaneteCell.identifier)
        nameTable.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        nameTable.delegate = self
        nameTable.dataSource = self
        nameTable.backgroundColor = .white
        nameTable.translatesAutoresizingMaskIntoConstraints = false
        return nameTable
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleInfo = UILabel()
        titleInfo.numberOfLines = 0
        titleInfo.font = .systemFont(ofSize: 20, weight: .bold)
        titleInfo.translatesAutoresizingMaskIntoConstraints = false
        return titleInfo
    }()
    
    private lazy var planeteLabel: UILabel = {
        let periode = UILabel()
        periode.numberOfLines = 0
        periode.font = .systemFont(ofSize: 20, weight: .bold)
        periode.translatesAutoresizingMaskIntoConstraints = false
        return periode
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationInfoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func configurationInfoView() {
        view.backgroundColor = .white
        navigationItem.title = "Информация"
        view.addSubview(titleLabel)
        view.addSubview(planeteLabel)
        view.addSubview(tableNameView)
        
        let area = view.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: area.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -10),
            
            planeteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            planeteLabel.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 10),
            planeteLabel.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -10),
            
            tableNameView.topAnchor.constraint(equalTo: planeteLabel.bottomAnchor, constant: 5),
            tableNameView.leadingAnchor.constraint(equalTo: area.leadingAnchor, constant: 5),
            tableNameView.trailingAnchor.constraint(equalTo: area.trailingAnchor, constant: -5),
            tableNameView.bottomAnchor.constraint(equalTo: area.bottomAnchor),
            
        ])
        
        NetWorking.sharedInstance.getTitleJSON(urlString: "https://jsonplaceholder.typicode.com/todos/1", searchItem: "title") { result in
            switch result {
            case .success(let titleString):
                
                DispatchQueue.main.async {
                    self.titleLabel.text = titleString
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        NetWorking.sharedInstance.getPeriodePlanete { [weak self] result in
            switch result {
            case .success(let planete):

                DispatchQueue.main.async {
                    self?.planeteLabel.text = "Планете \(planete.name) имеет \(planete.period ?? "0") дней"
                }
                
                for resident in planete.residents {
                    NetWorking.sharedInstance.getTitleJSON(urlString: resident, searchItem: "name") { name in
                        switch name {
                        case .success(let nameResident):
                            self?.nameHabitant.append(nameResident)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            case .failure(let error):
                switch error {
                case .noData:
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.planeteLabel.text = "Error: неправильный планет"
                    }
                    
                case .noDataAvaible:
                    print("Error Data")
                case .invaliddURL:
                    print("Неправильная сслыка, проверьте сслыку")
                case .dataNotFound:
                    print("Data don't found")
                }
            }
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameHabitant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NameOfResidencePlaneteCell.identifier, for: indexPath) as? NameOfResidencePlaneteCell else {
            let cellDefault = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            return cellDefault
        }
        
        cell.nameLabel.text = nameHabitant[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Имя жителей планата Татуин"
    }
}


/*
 
 buttonConfirmation.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
 buttonConfirmation.center = self.view.center
 buttonConfirmation.layer.cornerRadius = 10
 buttonConfirmation.actionButton = {
     
     let alertController = UIAlertController(title: "Выйти из этой страницы", message: "Хотите выйти ?", preferredStyle: .alert)

     let cancelButton = UIAlertAction(title: "Да", style: .cancel) { _ in
         self.dismiss(animated: true)
         print("Вышел")
     }
     alertController.addAction(cancelButton)

     let okButton = UIAlertAction(title: "Нет", style: .destructive) { _ in
         print("Еще не зокнчил")
     }
     alertController.addAction(okButton)
     self.present(alertController, animated: true)
 }
 
 */
