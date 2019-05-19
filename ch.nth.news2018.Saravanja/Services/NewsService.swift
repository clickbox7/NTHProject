//
//  NewsService.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

enum ServiceResult<Value> {
    case success(Value)
    case failure
}

protocol NewsServiceProtocol {
    func fetchAll(_ type: NewsType, _ sorted: NewsSorted, page: Int, completion: @escaping (ServiceResult<NewsResponse>) -> Void)
}

class NewsService: NewsServiceProtocol {
    
    func fetchAll(_ type: NewsType, _ sorted: NewsSorted, page: Int, completion: @escaping (ServiceResult<NewsResponse>) -> Void) {
        
        guard let url = URL(string: ApiPaths.newsApi(type, sorted, page)) else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error)
                completion(.failure)
            }
            
            guard let recievedData = data else {
                print("Wrong data")
                return completion(.failure)
            }
            
           let decoder = JSONDecoder()
            guard let decoded = try? decoder.decode(NewsResponse.self, from: recievedData) else {
                print("Unable to decode json")
                return completion(.failure)
            }
           //let decoded = try! decoder.decode(NewsResponse.self, from: recievedData)
            completion(.success(decoded))
        }
        
        task.resume()
        
    }
    
}

