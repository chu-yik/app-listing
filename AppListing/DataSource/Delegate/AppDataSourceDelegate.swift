//
//  AppDataSourceDelegate.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation

/// Protocol for delegate of an AppDataSourceProtocol implementation,
/// this should be conformed by VC that displays the App Listing
protocol AppDataSourceDelegate: class
{
    func grossingAppDataUpdated()
    func failedGettingGrossingApps()
}
