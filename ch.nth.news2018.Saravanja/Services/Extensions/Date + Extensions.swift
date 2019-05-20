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
        let calendar = Calendar(identifier: .gregorian)
        let calendarComponents = calendar.dateComponents(.init(arrayLiteral: .day, .hour, .minute, .second), from: date)
        let dateString = date.toString()
        
        guard let day = calendarComponents.day, day < 1 else {
            return dateString
        }
        
        if let hour = calendarComponents.hour, hour != 0 {
            switch hour {
            case 1:
                return "One hour ago"
            case 2...24:
                return "\(hour)' s ago"
            default:
                break
                
            }
        }
        
        if let minute = calendarComponents.minute, minute != 0 {
            switch minute {
            case 1:
                return "One minute ago"
            case 2...60:
                return "\(minute)' s ago"
            default:
                break
            }
            
            
        }
        
        if let second = calendarComponents.second, second != 0 {
            switch second {
            case 1:
                return "One second ago"
            case 2...60:
                return "\(second)' s ago"
            default:
                break
                
            }
            
           
        }
        
        return "Just now.."
    }
    
}
