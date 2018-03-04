//
//  JsonParserProtocol.swift
//  AppListing
//
//  Created by MC on 4/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import SwiftyJSON

/// Defines protocol for a JSON parser being used by the AppDataSourceProtocol
protocol JsonParserProtocol
{
    func parse(json: JSON) -> [App]
    func parseRating(json: JSON) -> [AppRating]
}
