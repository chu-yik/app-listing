//
//  DataAPIProtocol.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

/// Protocol for a data API providing urls for App listing or searching
protocol DataAPIProtocol
{
    var grossingApp: String { get }
    var freeApp: String { get }
    
    /// takes an array of App ids for search, will throw if the array is empty
    func urlToSearch(ids: [String]) throws-> String
}
