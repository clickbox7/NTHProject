//
//  NewsViewModel.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

typealias EmptyCallback = () -> Void

enum NewsType {
    case all
    case top
    
    var apiPath: String {
        switch self {
        case .all:
            return "everything"
        case .top:
            return "top-headlines"
        }
    }
}

enum NewsSorted {
    case date
    case popularity
    
    var apiPath: String {
        switch self {
        case .date:
            return "sortBy=publishedAt"
        case .popularity:
            return "sortBy=popularity"
        }
    }
}

class NewsViewModel {
    
    enum Constants {
        static let numberOfItemsPerPage = 20
    }
    
    private let newsService: NewsServiceProtocol
    var onError: EmptyCallback?
    var onComplete: EmptyCallback?
    var onGoToDetails: ((News) -> Void)?
    var inSearchMode = false
    
    private var news: [News] = []
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    var itemCount: Int {
        return news.count
    }
    
    func itemAt(_ index: Int) -> NewsCellModel? {
        guard let item = news[safe: index] else {
            print("Can't get item at index \(index)")
            return nil
        }
        
        let author: String = {
            guard let author = item.author, !author.isEmpty else {
                return "Unknown author"
            }
            return author
        }()
        
        let image: PlaceholderImage = {
            guard let imageURL = item.urlToImage, let url = URL(string: imageURL) else {
                return .placeholder(#imageLiteral(resourceName: "blackNoProfile"))
            }
            return .real(url)
        }()
        
        return NewsCellModel(title: item.title,
                             author: author,
                             image: image,
                             timestamp: item.publishedAt)
    }
    
    
    func goToDetails(item: News) {
        onGoToDetails?(item)
    }
    
    func selectItem(at index: Int) -> News? {
        guard let item = news[safe: index] else {
            print("Can't get item at index \(index)")
            return nil
        }
        return item
    }
    
    
    private var isAllContentLoaded = false
    private var pageNumber = 1
    
    func loadData(type: NewsType = .all, sorted: NewsSorted = .date) {
        self.pageNumber = 1
        self.isAllContentLoaded = false
        self.loadMoreData(type: type)
    }
    
    func loadMoreData(type: NewsType = .all, sorted: NewsSorted = .date) {
        guard !isAllContentLoaded else {
            return
        }
        
        self.loadData(type: type, sorted: sorted, page: self.pageNumber)
    }
    
    private func loadData(type: NewsType = .all, sorted: NewsSorted = .date, page: Int) {
        guard !isAllContentLoaded else {
            return
        }
        
        self.newsService.fetchAll(type, sorted, page: page) { [weak self] result in
            self?.handleNewsResult(result)
        }
        
    }
    private func handleNewsResult(_ result: ServiceResult<NewsResponse>) {
        switch result {
        case let .success(items):
            guard let articles = items.articles else { return }
            if self.pageNumber == 1 {
                self.news = articles
                print(items.totalResults)
                print(articles.count)
            } else {
                self.news.append(contentsOf: articles)
            }
            if articles.count < Constants.numberOfItemsPerPage {
                self.isAllContentLoaded = true
            } else {
                self.pageNumber += 1
            }
            self.onComplete?()
        case .failure:
            onError?()
        }
    }
    
    func showFilterResults(keyword: String) {
        
        if !keyword.isEmpty {
            ApiPaths.keyword = keyword
            loadData()
        } else {
            ApiPaths.keyword = "bitcoin"
            loadData()
        }
        
        
    }
    
}

