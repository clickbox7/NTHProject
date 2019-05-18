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
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var model: NewsCellModel? {
        didSet {
            guard let model = model else { return }
            
            
                cellImage.setImage(with: model.image)
                titleLabel.text = model.title
                timestampLabel.text = model.timestamp
                authorLabel.text = model.author
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        timestampLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        titleLabel.numberOfLines = 0
        cellImage.layer.cornerRadius = 7
        cellImage.layer.masksToBounds = true
        cellImage.contentMode = .scaleAspectFill
        selectionStyle = .none
        
    }
}


