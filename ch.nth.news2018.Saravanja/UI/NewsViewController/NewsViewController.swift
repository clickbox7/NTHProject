//
//  NewsViewController.swift
//  ch.nth.news2018.Saravanja
//
//  Created by Kristian Saravanja on 17/05/2019.
//  Copyright © 2019 Kristian Saravanja. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    fileprivate enum Constants {
        static let newsCellId = "newsCell"
        static let newsDetailsViewController = "NewsDetailsViewController"
    }
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewModel()
        createTableView()
        title = "News"
        
        viewModel.loadData()
    }
    
    private func createTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: Constants.newsCellId)
    }
    
    private func addViewModel() {
        
        viewModel = NewsViewModel(newsService: ServiceLocator.factory.newsServiceProtocol)
    }
    
    private func addCallbacks(to: NewsViewModel) {
        
        viewModel.onError = {
            print("There has been an error")
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: Constants.newsCellId, for: indexPath) as! NewsTableViewCell
        //cell.model = viewModel.models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(123)
        let post = viewModel.models[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.newsDetailsViewController, bundle: nil)
        let postDetailsViewController = storyboard.instantiateViewController(withIdentifier: Constants.newsDetailsViewController) as! NewsDetailsViewController
        let postDetailsViewModel = NewsDetailsViewModel(title: post.title)
        postDetailsViewController.viewModel = postDetailsViewModel
        navigationController?.pushViewController(postDetailsViewController, animated: true)
    }
    
    
}
