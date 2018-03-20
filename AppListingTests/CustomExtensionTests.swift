//
//  CustomExtensionTests.swift
//  AppListingTests
//
//  Created by MC on 20/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import XCTest
@testable import AppListing

class CustomExtensionTests: XCTestCase
{    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultReuseIdentifierWorksForUITableViewCell()
    {
        let expected = "AppListing.FreeAppCell"
        XCTAssertEqual(FreeAppCell.defaultReuseIdentifier, expected)
    }
    
    func testDefaultReuseIdentifierWorksForUICollectionViewCell()
    {
        let expected = "AppListing.GrossingAppCell"
        XCTAssertEqual(GrossingAppCell.defaultReuseIdentifier, expected)
    }
    
    func testNibNameWorksForFreeAppCell()
    {
        let expected = "FreeAppCell"
        XCTAssertEqual(FreeAppCell.nibName, expected)
    }
    
    func testNibNameWorksForGrossingAppCell()
    {
        let expected = "GrossingAppCell"
        XCTAssertEqual(GrossingAppCell.nibName, expected)
    }
}
