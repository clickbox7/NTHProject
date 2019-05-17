//
//  ServiceFactory.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    var newsServiceProtocol: NewsServiceProtocol { get }
}

enum ServiceLocator {
    
    static let factory: ServiceFactory = DefaultServiceFactory()
}

private struct DefaultServiceFactory: ServiceFactory {
    
    var newsServiceProtocol: NewsServiceProtocol {
        return NewsService()
    }
    
    
    
    
}
