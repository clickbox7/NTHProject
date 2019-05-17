//
//  NewsTableViewCell.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var model: NewsCellModel? {
        didSet {
            guard let model = model else { return }
            
                //cellImage.image = model.image
                titleLabel.text = model.title
                timestampLabel.text = model.timestamp
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}


