//
//  ITunesDataAPI.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation

/// Implementation of the DataAPIProcol, this queries the iTunes API
/// to get grossing/free App, and search for App by id
struct ITunesDataAPI: DataAPIProtocol
{
    private enum url
    {
        static let replace = "{size}"
        static let grossing = "https://itunes.apple.com/hk/rss/topgrossingapplications/limit={size}/json"
        static let free = "https://itunes.apple.com/hk/rss/topfreeapplications/limit={size}/json"
        static let search = "https://itunes.apple.com/hk/lookup?id="
    }
    
    private(set) var grossingApp: String
    private(set) var freeApp: String
    
    init(grossingAppSize: Int, freeAppSize: Int)
    {
        grossingApp = url.grossing.replacingOccurrences(of: url.replace, with: "\(grossingAppSize)", options: .literal, range: nil)
        freeApp = url.free.replacingOccurrences(of: url.replace, with: "\(freeAppSize)", options: .literal, range: nil)
    }
    
    func urlToSearch(ids: [String]) throws -> String
    {
        guard !ids.isEmpty else { throw ApiError.invalidIdToSearch }
        
        var searchUrl = url.search
        for id in ids
        {
            searchUrl += "\(id),"
        }
        searchUrl.removeLast()
        return searchUrl
    }
}
