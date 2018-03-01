//
//  ITunesDataAPI.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation

struct ITunesDataAPI
{
    private enum url
    {
        static let replace = "{size}"
        static let grossing = "https://itunes.apple.com/hk/rss/topgrossingapplications/limit={size}/json"
        static let free = "https://itunes.apple.com/hk/rss/topfreeapplications/limit={size}/json"
        static let search = "https://itunes.apple.com/hk/lookup?id="
    }
    
    private(set) var grossingAppSize: Int
    private(set) var freeAppSize: Int
    
    lazy var grossingApp: String = {
        url.grossing.replacingOccurrences(of: url.replace, with: "\(grossingAppSize)", options: .literal, range: nil)
    }()
    
    lazy var freeApp: String = {
        url.free.replacingOccurrences(of: url.replace, with: "\(freeAppSize)", options: .literal, range: nil)
    }()
    
    init(grossingAppSize: Int, freeAppSize: Int)
    {
        self.grossingAppSize = grossingAppSize
        self.freeAppSize = freeAppSize
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
