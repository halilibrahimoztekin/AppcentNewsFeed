//
//  Article.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import Foundation
struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let source : Source?
   let author : String?
   let url : String?
   let urlToImage : String?
   let publishedAt : String?
   let content : String?
}
