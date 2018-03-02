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
}
