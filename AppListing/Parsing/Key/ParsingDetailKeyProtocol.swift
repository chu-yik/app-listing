//
//  ParsingDetailKeyProtocol.swift
//  AppListing
//
//  Created by MC on 2/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

/// Protocol for keys used to parse JSON response
/// from Detail search result into AppWithRating Model Object
protocol ParsingDetailKeyProtocol
{
    var dataStart: [JSONSubscriptType] { get }
    var id: [JSONSubscriptType] { get }
    var rating: [JSONSubscriptType] { get }
    var count: [JSONSubscriptType] { get }
}
