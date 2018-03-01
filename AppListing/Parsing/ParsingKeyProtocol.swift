//
//  ParsingKeyProtocol.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation

/// Protocol for keys used to parse JSON response into App Model Object
protocol ParsingKeyProtocol
{
    var dataStart: [String] { get }
    var id: [String] { get }
    var name: [String] { get }
    var category: [String] { get }
    var artist: [String] { get }
    var summary: [String] { get }
    var imageUrl: [String] { get }
}
