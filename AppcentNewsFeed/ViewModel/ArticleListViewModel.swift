//
//  ArticleListViewModel.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 27.10.2021.
//

import Foundation
struct ArticleListViewModel {
    var articles: [Article]
}

extension ArticleListViewModel {
    
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = articles[index]
        return ArticleViewModel(article)
    }
    
}


