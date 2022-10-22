//
//  ModelInfo.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 21.10.2022.
//

import Foundation

struct Planets: Decodable {
    var name: String
    var period: String?
    //var url: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case period = "orbital_period"
        //case url
        case residents
    }
}

enum NetWorkError: Error {
    case noDataAvaible
    case invaliddURL
    case dataNotFound
    case noData
}


struct NetWorking {
    
    static let sharedInstance = NetWorking()
    
    let session = URLSession.shared
    //let urlString = "https://jsonplaceholder.typicode.com/todos/10"
    let urlPlanets = "https://swapi.dev/api/planets/1"
    
    func getTitleJSON(urlString: String, searchItem: String, completion: @escaping (Result<String, NetWorkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invaliddURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print((response as? HTTPURLResponse)?.statusCode ?? 0)
            }
                
            do {
                let answer = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                if let titleInfo = answer?["\(searchItem)"] as? String {
                    completion(.success(titleInfo))
                } else {
                    completion(.failure(.noData))
                }
                
            } catch {
                completion(.failure(.dataNotFound))
            }
            
        }
        
        dataTask.resume()
    }
 
    
    func getPeriodePlanete(completion: @escaping (Result<Planets, NetWorkError>) -> Void) {
        
        guard let url = URL(string: urlPlanets) else {
            completion(.failure(.invaliddURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let anwswer = try decoder.decode(Planets.self, from: jsonData)
                
                guard anwswer.name == "Tatooine" else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(anwswer))
                
            } catch {
                completion(.failure(.dataNotFound))
            }
        }
        
        dataTask.resume()
    }
}

