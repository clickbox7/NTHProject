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
    }
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: NewsViewModel!
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        addCallbacks()
        viewModel.loadData()
        addPullToRefresh()
        style()
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.loadData()
        case 1:
            viewModel.loadData(type: .top, sorted: .popularity)
        default:
            break
            
        }
        
    }
    private func style() {
        title = "News".local
        searchBar.delegate = self
        segmentedControl.tintColor = .gray
        segmentedControl.backgroundColor = .white
        segmentedControl.setTitle("News".local, forSegmentAt: 0)
        segmentedControl.setTitle("Top", forSegmentAt: 1)
        newsTableView.keyboardDismissMode = .onDrag
        view.backgroundColor = .white
    }
    
    private func addPullToRefresh() {
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefreshActivated), for: .valueChanged)
    }
    
    @objc func pullToRefreshActivated() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.loadData()
        case 1:
            viewModel.loadData(type: .top, sorted: .popularity)
        default:
            break
        }
    }
    
    private func createTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: Constants.newsCellId)
    }
    
    private func addCallbacks() {
        
        viewModel.onError = { [weak self] in
            print("There has been an error")
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            self?.showAlert(title: "There has been somekind of error!", message: "Try again later!", actions: [okAction])
        }
        
        viewModel.onComplete = { [weak self] in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = viewModel.itemCount
        if indexPath.row == lastRowIndex - 1 {
            viewModel.loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: Constants.newsCellId, for: indexPath) as! NewsTableViewCell
        cell.model = viewModel.itemAt(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = viewModel.selectItem(at: indexPath.row) else { return }
        viewModel.goToDetails(article: article)
        
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        viewModel.showFilterResults(keyword: keyword, type: .all)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            guard let keyword = searchBar.text else { return }
            if keyword.isEmpty {
                viewModel.showFilterResults(keyword: keyword, type: .all)
            }
        case 1:
            guard let keyword = searchBar.text else { return }
            if keyword.isEmpty {
                viewModel.showFilterResults(keyword: keyword, type: .top)
            }
        default:
            break
        }
    }
    
}
