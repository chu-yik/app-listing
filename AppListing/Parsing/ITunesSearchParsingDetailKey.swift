//
//  ITunesSearchParsingDetailKey.swift
//  AppListing
//
//  Created by MC on 2/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

/// Implementation of ParsingDetailKeyProtocol, keys are specific to ITunes Search API
struct ITunesSearchParsingDetailKey: ParsingDetailKeyProtocol
{
    let dataStart: [JSONSubscriptType] = ["results"]
    let id: [JSONSubscriptType] = ["trackId"]
    let rating: [JSONSubscriptType] = ["averageUserRating"]
    let count: [JSONSubscriptType] = ["userRatingCount"]
}
