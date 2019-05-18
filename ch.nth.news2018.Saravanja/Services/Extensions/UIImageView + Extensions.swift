//
//  UIImageView + Extensions.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit
import Kingfisher

enum PlaceholderImage {
    case placeholder(UIImage)
    case real(URL)
    
    init(_ imageURL: URL?, or placeholder: UIImage) {
        if let imageURL = imageURL {
            self = .real(imageURL)
        } else {
            self = .placeholder(placeholder)
        }
    }
}

extension UIImageView {
    
    func setImage(with url: URL) {
        kf.setImage(with: url)
    }
    
    func setImage(with placeholderImage: PlaceholderImage) {
        switch placeholderImage {
        case .placeholder(let image):
            self.image = image
        case .real(let url):
            self.setImage(with: url)
        }
    }
}
