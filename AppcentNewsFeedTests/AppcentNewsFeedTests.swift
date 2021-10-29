//
//  AppcentNewsFeedTests.swift
//  AppcentNewsFeedTests
//
//  Created by Bukefalos on 26.10.2021.
//

import XCTest
@testable import AppcentNewsFeed

class AppcentNewsFeedTests: XCTestCase {
    
    var keyword = ""
    var pagination = 1000
    var apiKey = ""

    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        webService().getFeed(apiKey: apiKey, keyword: keyword, pagination: pagination, completion: Article)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
