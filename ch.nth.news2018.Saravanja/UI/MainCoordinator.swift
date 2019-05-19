//
//  NewsCoordinator.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 19/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    var childCoordinators: [Coordinator] = []
    
    func start() -> UIViewController {
        
        rootViewController.viewControllers = [createNews()]
        rootViewController.showAsRoot()
        return rootViewController
    }
    
    private func createNews() -> UIViewController {
        let newsCoordinator = NewsCoordinator()
        newsCoordinator.parentCoordinator = self
        childCoordinators.append(newsCoordinator)
        let vc = newsCoordinator.start()
        return vc
    
    }
}
