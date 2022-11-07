//
//  ImageModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 03.11.2022.
//

import Foundation

struct ImageData {
    static let shared = ImageData()
        
    func savedImageFile(imageUrl: URL) {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let pathDirectory = path.appendingPathComponent(imageUrl.lastPathComponent)
        
        do {
            let dataImage = try Data(contentsOf: imageUrl)

            if FileManager.default.fileExists(atPath: pathDirectory.path)  {
                do {
                    try FileManager.default.removeItem(atPath: pathDirectory.path)
                } catch {
                    print(error.localizedDescription)
                }
            }
            FileManager.default.createFile(atPath: pathDirectory.path, contents: dataImage)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImage(completion: ([String]) -> Void) {
        
        let urlImage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var imageReceieved = [String]()
        
        do {
            imageReceieved = try FileManager.default.contentsOfDirectory(atPath: urlImage.path)
            completion(imageReceieved)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
    }
    
    func removeImage(image: String) {
        let urlImage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageDeletedUrl = urlImage.appendingPathComponent(image).path
        do {
            try FileManager.default.removeItem(atPath: imageDeletedUrl)
        } catch {
            print(error.localizedDescription)
        }
    }
}





