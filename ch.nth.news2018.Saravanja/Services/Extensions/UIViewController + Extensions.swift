//
//  ViewController + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 18/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit

protocol RootShowable: class {
    func showAsRoot()
}

extension RootShowable where Self: UIViewController {
    
    func showAsRoot() {
        guard  let window = window else {
            print("WARNING: no window!")
            return
        }
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
}

extension UIViewController: RootShowable {
    
    var window: UIWindow? {
        var appWindow = view.window
        if appWindow == nil {
            if UIApplication.shared.windows.count > 0 {
                appWindow = UIApplication.shared.windows[0]
            }
        }
        return appWindow
    }
    
}

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil, actions: [UIAlertAction] = []) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    class func instance() -> Self {
        if let vc = createFromStoryboard(type: self) {
            return vc
        } else {
            print("WARNING: can't create view controller from storybard:\(self)")
            return self.init()
        }
    }
    
    private class func createFromStoryboard<T: UIViewController>(type: T.Type) -> T? {
        
        let storyboardName = String(describing: type)
        
        let bundle = Bundle(for: T.self)
        
        guard bundle.path(forResource: storyboardName, ofType: "storyboardc") != nil else {
            return nil
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        
        guard let vc = storyboard.instantiateInitialViewController() else {
            print("no vc in storyboard(hint: check initial vc)") ; return nil
        }
        
        return vc as? T
    }
}
