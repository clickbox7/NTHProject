//
//  ViewController + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 18/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil, actions: [UIAlertAction] = []) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
