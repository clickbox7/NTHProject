//
//  String + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 18/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import Foundation

extension String {
    
    var local: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
        
    }
}
