//
//  Date + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 18/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: self)
}
    
    func timeAgoDisplay(date: Date) -> String {
        
        return ""
    }

}
