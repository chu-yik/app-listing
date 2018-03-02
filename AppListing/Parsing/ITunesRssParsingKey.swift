//
//  ITunesRssParsingKey.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

/// Implementation of ParsingKeyProtocol, keys are specific to ITunes RSS listing
struct ITunesRssParsingKey: ParsingKeyProtocol
{
    let dataStart: [JSONSubscriptType] = ["feed", "entry"]
    let id: [JSONSubscriptType] = ["id", "attributes", "im:id"]
    let name: [JSONSubscriptType] = ["im:name", "label"]
    let category: [JSONSubscriptType] = ["category", "attributes", "label"]
    let artist: [JSONSubscriptType] = ["im:artist", "label"]
    let summary: [JSONSubscriptType] = ["summary", "label"]
    let imageUrl: [JSONSubscriptType] = ["im:image", 2, "label"]
}
