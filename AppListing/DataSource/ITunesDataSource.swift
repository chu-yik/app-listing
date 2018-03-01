//
//  ITunesDataSource.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

class ITunesDataSource: NSObject, AppDataSourceProtocol
{
    
}

extension ITunesDataSource: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // TODO:
        return UICollectionViewCell()
    }
}

extension ITunesDataSource: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO:
        return UITableViewCell()
    }
}


