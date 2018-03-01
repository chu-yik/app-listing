//
//  ITunesRssParsingKey.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation

/// Implementation of ParsingKeyProtocol, keys are specific to ITunes RSS listing
struct ITunesRssParsingKey: ParsingKeyProtocol
{
    let dataStart: [String] = ["feed", "entry"]
    let id: [String] = ["id", "attributes", "im:id"]
    let name: [String] = ["im:name", "label"]
    let category: [String] = ["category", "attributes", "label"]
    let artist: [String] = ["im:artist", "label"]
    let summary: [String] = ["summary", "label"]
    let imageUrl: [String] = ["im:image", "label"]
}
