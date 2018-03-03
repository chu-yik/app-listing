//
//  ITunesDataAPITests.swift
//  AppListingTests
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import XCTest
@testable import AppListing

class ITunesDataAPITests: XCTestCase {
    
    let grossing = 10
    let free = 100
    var api: ITunesDataAPI!
    
    override func setUp()
    {
        super.setUp()
        api = ITunesDataAPI(grossingAppSize: grossing, freeAppSize: free)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApiReturnsCorrectUrlForGrossingApp()
    {
        let expected = "https://itunes.apple.com/hk/rss/topgrossingapplications/limit=10/json"
        XCTAssertEqual(expected, api.grossingApp)
    }
    
    func testApiReturnsCorrectUrlForFreeApp()
    {
        let expected = "https://itunes.apple.com/hk/rss/topfreeapplications/limit=100/json"
        XCTAssertEqual(expected, api.freeApp)
    }
    
    func testApiReturnsCorrectUrlForSearch()
    {
        let ids = ["123", "456", "789"]
        let expected = "https://itunes.apple.com/hk/lookup?id=123,456,789"
        let actual = try? api.urlToSearch(ids: ids)
        XCTAssertEqual(expected, actual)
    }
    
    func testApiThrowsForInvalidSearch()
    {
        XCTAssertThrowsError(try api.urlToSearch(ids: []))
    }
}
