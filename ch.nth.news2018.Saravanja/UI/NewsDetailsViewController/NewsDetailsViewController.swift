//
//  NewsDetailsViewController.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postTimestamp: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var postUrl: UILabel!
    
    var viewModel: NewsDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        style()
        viewModel.loadData()
        addGestureRecognizer()
        
    }
    
    private func addCallbacks() {
        viewModel.onComplete = { [weak self] data in
            self?.show(data: data)
        }
    }
    
    private func show(data: NewsDetailsViewModel.Post) {
        
        guard let imageURLString = data.image, !imageURLString.isEmpty, let url = URL(string: imageURLString) else {
            postImage.setImage(with: PlaceholderImage.placeholder(#imageLiteral(resourceName: "blackNoProfile")))
            postTitle.text = data.title
            postAuthor.text = data.author
            postTimestamp.text = data.timestamp
            postDescription.text = data.description
            postUrl.text = data.url
            return
        }
        
        postImage.setImage(with: url)
        postTitle.text = data.title
        postAuthor.text = data.author
        postTimestamp.text = data.timestamp
        postDescription.text = data.description
        postUrl.text = data.url
    }
    
    
    private func style() {
        postImage.contentMode = .scaleToFill
        postTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        postTitle.numberOfLines = 0
        postAuthor.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        postTimestamp.font = UIFont.systemFont(ofSize: 10, weight: .light)
        postDescription.numberOfLines = 0
        postDescription.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        postUrl.textColor = .smokeyBlue
        
        postUrl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        postUrl.numberOfLines = 0
        postUrl.isUserInteractionEnabled = true
        
    }
    
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openOriginalArticle))
        postUrl.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openOriginalArticle() {
        guard let link = postUrl.text, let url = URL(string: link) else {return }
        let urlRequest = URLRequest(url: url)
        viewModel.showWebView(urlRequest: urlRequest)
        
    }
    
}
