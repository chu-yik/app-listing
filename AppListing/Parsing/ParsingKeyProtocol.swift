//
//  ParsingKeyProtocol.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

/// Protocol for keys used to parse JSON response into App Model Object
protocol ParsingKeyProtocol
{
    var dataStart: [JSONSubscriptType] { get }
    var id: [JSONSubscriptType] { get }
    var name: [JSONSubscriptType] { get }
    var category: [JSONSubscriptType] { get }
    var artist: [JSONSubscriptType] { get }
    var summary: [JSONSubscriptType] { get }
    var imageUrl: [JSONSubscriptType] { get }
}
