//
//  ProfileManagementNetwork.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 19.11.2022.
//

import Foundation

struct Answer: Decodable {
    var articles: [Articles]
}

struct Articles: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
}

enum DownloadError: Error {
    case noDataAvaible
    case invaliddURL
    case dataNotFound
    case noData
}

struct ProfileManagementNetwork {
    static let shared = ProfileManagementNetwork()
    let session = URLSession.shared
    
    func reloadDataNetwork(_ urlString: String, _ completion: @escaping (Result<[Answer], DownloadError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invaliddURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.dataNotFound))
                return
            }
            
            do {
                let answer = try JSONDecoder().decode(Answer.self, from: jsonData)
                completion(.success([answer]))
            } catch {
                completion(.failure(.noData))
            }
        }
        dataTask.resume()
    }
    
    func downloadImg(_ urlImage: String, _ completion: @escaping (_ imgaeData: Data) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        
        session.dataTask(with: url) { data, _, _ in
            
            guard let imageData = data else { return }
            
            completion(imageData)
            
        }.resume()
    }
}
