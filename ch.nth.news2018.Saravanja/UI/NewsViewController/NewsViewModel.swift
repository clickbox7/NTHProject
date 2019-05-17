//
//  NewsViewModel.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

typealias EmptyCallback = () -> Void

class NewsViewModel {
    
    var newsService: NewsServiceProtocol!
    var onError: EmptyCallback?
    
    private var news: [News] = [] 
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    var models: [NewsCellModel] {
        return news.map { news in
            return NewsCellModel(title: news.title,
                                 image: news.urlToImage ?? "",
                                 timestamp: news.publishedAt
            )
            
        }
        
    }
    
    func loadData() {
        newsService.fetchAll { (result) in
            switch result {
            case .success(let items):
                print(items.totalResults)
                self.news = items.articles
            case .failure:
                self.onError?()
            }
        }
    }

}
