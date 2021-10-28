//
//  WebViewController.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 29.10.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView = WKWebView()
    var url = "https://google.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        let url2 = URL(string: url)
        webView.load(URLRequest(url: url2!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    

  

}
