//
//  Coordinator.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    @discardableResult
    func start() -> UIViewController
}
