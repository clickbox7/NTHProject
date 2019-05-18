//
//  Array + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 18/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

extension Array {
    
    subscript(safe index: Index) -> Element? {
        return  index >= 0 && index < self.count ? self[index] : nil
    }
}
