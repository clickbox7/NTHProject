//
//  News.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [News]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

struct News: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    
//    var date: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        guard let date = dateFormatter.date(from: publishedAt) else { return nil }
//        return date
//    }
    
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    
    struct Source: Codable {
        let id: String?
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }
    
}
