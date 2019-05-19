//
//  NewsCoordinator.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 19/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation
import UIKit

class NewsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: MainCoordinator?
    
    func start() -> UIViewController {
        return createNews()
    }
    
    private func createNews() -> UIViewController {
        let newsViewController = NewsViewController.instance()
        let newsViewModel = NewsViewModel(newsService: ServiceLocator.factory.newsServiceProtocol)
        newsViewController.viewModel = newsViewModel
        
        newsViewModel.onGoToDetails = { [weak self] item in
            guard let vc = self?.createNewsDetails(item: item) else { return }
            self?.parentCoordinator?.rootViewController.pushViewController(vc, animated: true)
          
        }
    
        return newsViewController
    }
    
    private func createNewsDetails(item: News) -> UIViewController {
        let newsDetailsVC = NewsDetailsViewController.instance()
        let newsDetailsVM = NewsDetailsViewModel(item: item)
        
        newsDetailsVM.onShowWebView = { [weak self] urlRequest in
            guard let vc = self?.createWebView(request: urlRequest) else { return }
            self?.parentCoordinator?.rootViewController.pushViewController(vc, animated: true)
        }
        
        newsDetailsVC.viewModel = newsDetailsVM
        
        return newsDetailsVC
    }
    
    private func createWebView(request: URLRequest) -> UIViewController {
        let webViewVC = WebViewViewController(request: request)
        
        return webViewVC
    }
}
