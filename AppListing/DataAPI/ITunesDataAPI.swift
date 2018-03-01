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
    private(set) var grossingAppSize: Int
    private(set) var freeAppSize: Int
    
    lazy var grossingApp: String = {
        return ""
    }()
    
    lazy var freeApp: String = {
        return ""
    }()
    
    init(grossingAppSize: Int, freeAppSize: Int)
    {
        self.grossingAppSize = grossingAppSize
        self.freeAppSize = freeAppSize
    }
    
    func urlToSearch(ids: [String]) -> String
    {
        return ""
    }
}
