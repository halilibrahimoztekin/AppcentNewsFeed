//
//  WebService.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import Foundation
import Alamofire

class webService{
    
    
    func getFeed( apiKey: String,keyword: String,pagination : String, completion: @escaping ([Article]?) -> ()) {
        
        // Keywordu sorguya uygun hale getirip url şemasını oluşturuyorum
        let keywordQuery = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "q", value: keywordQuery),
            URLQueryItem(name: "page", value: pagination),
            URLQueryItem(name: "Apikey", value: apiKey)
        ]
        let urlString = components.string
            
        
        
       // sunucuya istek gönderiyorum
        URLSession.shared.dataTask(with: URL(string: urlString!)!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                // Datayı JSoon decode ile Articlelist structıma göre ayrıştırıyorum
                let articlesList = try? JSONDecoder().decode(ArticleList.self, from: data)
                completion(articlesList?.articles)
            }
            
        }.resume()
        
        }
    
        

}
