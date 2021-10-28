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
        
        let urlString = "https://newsapi.org/v2/everything?q="+keyword+"&page="+pagination+"&apiKey="+apiKey
       URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let articlesList = try? JSONDecoder().decode(ArticleList.self, from: data)
                completion(articlesList?.articles)
            }
            
        }.resume()
        
        }
    
        

}
