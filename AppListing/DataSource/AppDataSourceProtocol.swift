//
//  AppDataSourceProtocol.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// Protocol defining the AppDataSource
protocol AppDataSourceProtocol: UITableViewDataSource, UICollectionViewDataSource
{
    weak var delegate: AppDataSourceDelegate? { get set }
    func fetchGrossingApps()
    func fetchFreeApps()
    /// filter the data source with given search string, search is case insensitive
    /// it will be up to the caller to decide if leading/trailing whitespaces shall be trimmed
    func filterData(withSearch: String)
}
