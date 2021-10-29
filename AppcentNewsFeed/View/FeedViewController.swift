//
//  FeedViewController.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import UIKit
import Alamofire



class FeedViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
  
    let urlString = "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey="
    let apiKey  = "fdbfc969563f49e4935633696d3d2bb1"
    var keyword = "turkey"
    var pagination : Int = 2
    var up = true
    var selectedFeed : ArticleViewModel!
    private var feeds : ArticleListViewModel!
    var selectedNews = "Feed"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedNews = "Feed"
        navigationItem.title = "Appcent News App"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        configureRefreshControl()
        
       // webService().parseReq(urlString: urlString)
        self.tableView.contentInset.bottom = self.tabBarController?.tabBar.frame.height ?? 0
        getData()
        
        navigationItem.backButtonTitle = "Geri"
    
    }
        func getData(){
            webService().getFeed( apiKey: apiKey, keyword: keyword, pagination: String(pagination)) { articles in
                if let articles = articles {
                    self.feeds = ArticleListViewModel(articles: articles)
                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                    
                    
                }
            }
            keyword = "usa"
            
        }
    
    func moreData(){
        
        webService().getFeed( apiKey: apiKey, keyword: keyword, pagination: String(pagination)) { articles in
            if let articles = articles {
                
                self.feeds.articles += articles
                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                    self.up = true
                                }
                print("Selam \(self.feeds.articleAtIndex(2).description)")
                
            }
        }
        
        
    }
        
        
        // Do any additional setup after loading the view.
        
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
       // Update your content…
        getData()
        
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
       }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.feeds == nil ? 0 : self.feeds.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTableViewCell
        let feed = self.feeds.articleAtIndex(indexPath.row)
        cell.configure(for: feed)
        
        print(String(pagination) + " " + "" + String(self.feeds.articles.count))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.feeds.articles.count - 1
        
        if indexPath.row == lastElement{
            pagination += 1
            
            if up {
                moreData()
                up = false
            }
            
        }
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       selectedFeed = self.feeds.articleAtIndex(indexPath.row)
        performSegue(withIdentifier: "FeedtoDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedtoDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.choosenFeed = selectedFeed
            destinationVC.selectedNews = selectedNews
            
        }
       
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("aramaya inan")
        getData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("arama iptal edildi")
        self.searchBar.showsCancelButton = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("text tit editing end")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.setShowsCancelButton(true, animated: true)
        keyword = searchText
        getData()
        print(searchText)
    }
    
  

}
