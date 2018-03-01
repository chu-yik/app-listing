//
//  ITunesDataSource.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// Implementation of the AppDataSourceProtocol, which in term conforms to both
/// UITableViewDataSource and UICollectionViewDataSource
class ITunesDataSource: NSObject
{    
    weak var delegate: AppDataSourceDelegate?
    
    var grossingApps: [App] = []
    
    private var api: DataAPIProtocol
    private var key: ParsingKeyProtocol
    
    init(api: DataAPIProtocol, key: ParsingKeyProtocol)
    {
        self.api = api
        self.key = key
    }
}

extension ITunesDataSource: AppDataSourceProtocol
{
    func fetchGrossingApps()
    {
        fetch(from: api.grossingApp, ifSuccessful: { (json) in
            self.grossingApps = self.parse(json: json)
            self.delegate?.grossingAppDataUpdated()
        }) { (eror) in
            self.delegate?.failedGettingGrossingApps()
        }
    }
    
    private func fetch(from url: String,
                       ifSuccessful successCallback: @escaping (JSON) -> (),
                       ifFailed failureCallback: @escaping (Error) -> ())
    {
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
            switch response.result
            {
            case .success(let value):
                successCallback(JSON(value))
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
    private func parse(json: JSON) -> [App]
    {
        var apps: [App] = []
        
        return apps
    }
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
