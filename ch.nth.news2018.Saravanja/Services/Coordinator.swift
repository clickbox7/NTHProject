//
//  Coordinator.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 19/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    func start() -> UIViewController
    
}

extension Coordinator {
    
    func showAsRoot() {
        let vc = start()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.rootCoordinator = self
        vc.showAsRoot()
    }
}
