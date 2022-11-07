//
//  OnboardingController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.11.2022.
//

import UIKit

class OnboardingController: UIViewController {
    
    weak var coordinator: OnboardingCoordinator?

    var imageData = ImageData.shared
    
    var imageReceved = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var cameraButton: UIBarButtonItem = {
        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(didTapCamera))
        return camera
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        tableView.register(NameOfResidencePlaneteCell.self, forCellReuseIdentifier: NameOfResidencePlaneteCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    lazy var getStartButton: CustomButton = {
        let getStart = CustomButton(title: "Get Start", bgColor: UIColor(red: 34/250, green: 38/250, blue: 58/250, alpha: 100/250), tilteColor: .white)
        return getStart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingConfiguration()
    }

    private func onboardingConfiguration() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = cameraButton
       // UserDefaults.standard.set(true, forKey: "isFirstTime")
        
        navigationItem.title = "Документы"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        actionDidTaped()
        
        view.addSubview(getStartButton)
        view.addSubview(tableView)
           
        NSLayoutConstraint.activate([
            getStartButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            getStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            getStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            getStartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            getStartButton.heightAnchor.constraint(equalToConstant: 45),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        getStartButton.layer.cornerRadius = 15

        imageData.loadImage { imageSaved in
            for image in imageSaved {
                imageReceved.append(image)
            }
        }
    }
   
    @objc func didTapCamera() {
        chooseCameraOrGallery()
    }
    
    private func imagePixel(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePixel = UIImagePickerController()
        imagePixel.sourceType = sourceType
        return imagePixel
    }
    
    private func chooseCameraOrGallery() {
        let messageAlert = UIAlertController(title: "Add new image", message: "Choose", preferredStyle: .actionSheet)
        messageAlert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            let gallery = self.imagePixel(sourceType: .photoLibrary)
            gallery.delegate = self
            self.present(gallery, animated: true)
        }))
        
        messageAlert.addAction(UIAlertAction(title: "Камера (Только с реальным устройством)", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            let camera = self.imagePixel(sourceType: .camera)
            camera.delegate = self
            self.present(camera, animated: true)
        }))
        
        messageAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(messageAlert, animated: true)
    }
    
    private func actionDidTaped() {
        getStartButton.actionButton = {
            self.coordinator?.goToLogin()
        }
    }
}

extension OnboardingController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageReceved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NameOfResidencePlaneteCell.identifier, for: indexPath) as?
                NameOfResidencePlaneteCell else {
            let cellDefault = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            return cellDefault
        }
        
        cell.nameLabel.text = imageReceved[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            imageData.removeImage(image: imageReceved [indexPath.row])
            imageReceved.remove(at: indexPath.row)
        }
    }
}

extension OnboardingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageUrl = info[.imageURL] as! URL
        imageData.savedImageFile(imageUrl: imageUrl)
        
        imageData.loadImage { image in
            imageReceved = image
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             picker.dismiss(animated: true)
        }
    }
}



