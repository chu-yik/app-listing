//
//  ITunesJsonParser.swift
//  AppListing
//
//  Created by MC on 4/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

struct ITunesJsonParser: JsonParserProtocol
{
    private var key: ParsingKeyProtocol
    private var ratingKey: ParsingRatingKeyProtocol
    
    init(key: ParsingKeyProtocol, ratingKey: ParsingRatingKeyProtocol)
    {
        self.key = key
        self.ratingKey = ratingKey
    }
    
    func parse(json: JSON) -> [App]
    {
        var apps: [App] = []
        let entries = json[key.dataStart].arrayValue
        for entry in entries
        {
            let app = App(id: entry[key.id].stringValue,
                          name: entry[key.name].stringValue,
                          category: entry[key.category].stringValue,
                          artist: entry[key.artist].stringValue,
                          summary: entry[key.summary].stringValue,
                          imageUrl: entry[key.imageUrl].stringValue)
            apps.append(app)
        }
        return apps
    }
    
    func parseRating(json: JSON) -> [AppRating]
    {
        var appRatings: [AppRating] = []
        let entries = json[ratingKey.dataStart].arrayValue
        for entry in entries
        {
            let appRating = AppRating(id: entry[ratingKey.id].stringValue,
                                      rating: entry[ratingKey.rating].doubleValue,
                                      count: entry[ratingKey.count].stringValue)
            appRatings.append(appRating)
            
        }
        return appRatings
    }
}
