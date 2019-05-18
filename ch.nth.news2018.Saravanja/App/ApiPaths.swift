//
//  ApiPaths.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

enum ApiPaths {
    
    static let keyword = "bitcoin"
    static let baseURL = "https://newsapi.org/v2/"
    static let apiKey = "0873f34a9c1344e291af05ce732ea2d2"
    static func newsApi(_ type: NewsType,_ pageNumber: Int) -> String {
        return "\(baseURL)\(type.apiPath)?q=\(keyword)&page=\(pageNumber)&from=2019-05-01&sortBy=publishedAt&apiKey=\(apiKey)"
    }
    

}
