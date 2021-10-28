//
//  ArticleViewModel.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 27.10.2021.
//

import Foundation
struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: String {
        return self.article.title ?? ""
    }
    
    var description: String {
        return self.article.description ?? ""
    }
    
   var author: String {
       return self.article.author ?? "No Author Info"
    }
  var url : String {
      return self.article.url ?? ""
  }
  var urlToImage : String {
      return self.article.urlToImage ?? ""
  }
  var publishedAt : String {
      return self.article.publishedAt ?? ""
  }
 var content : String {
     return self.article.content ?? ""
 }
    var source : String {
        return self.article.source?.name ?? ""
    }
    
}
