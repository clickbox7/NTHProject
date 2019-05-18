//
//  NewsDetailsViewModel.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

class NewsDetailsViewModel {
    
    let item: News!
    var onComplete: ((Post) -> Void)?
    
    
    init(item: News) {
        self.item = item
    }
    
    struct Post {
        let image: String?
        let title: String
        let author: String
        let timestamp: String
        let description: String
        let url: String
    }
    
    
    private func postData(item: News) -> Post {
        
        let author: String = {
            guard let author = item.author, !author.isEmpty else { return  "Unknown author" }
            return author
        }()
        
        let description: String = {
            guard let description = item.description, !description.isEmpty else { return "No description for this article" }
            return description
        }()
        
        let post = Post(image: item.urlToImage,
                        title: item.title,
                        author: author,
                        timestamp: item.publishedAt,
                        description: description,
                        url: item.url)
    
        return post
        
    }
    
    func loadData() {
        
        guard let item = item else { return }
        let data = postData(item: item)
        onComplete?(data)
        
  
    }
}
