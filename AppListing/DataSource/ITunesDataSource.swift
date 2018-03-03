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
    var grossingAppsFiltered: [App] = []
    var freeApps: [App] = []
    var freeAppsFiltered: [App] = []
    
    var freeAppIndexMap: [String: Int] = [:]
    var freeAppsWithRating: [String : AppWithRating] = [:]
    
    private var api: DataAPIProtocol
    private var key: ParsingKeyProtocol
    private var detailKey: ParsingDetailKeyProtocol
    
    init(api: DataAPIProtocol, key: ParsingKeyProtocol, detailKey: ParsingDetailKeyProtocol)
    {
        self.api = api
        self.key = key
        self.detailKey = detailKey
    }
}

// MARK: - private helpers - searching related
extension ITunesDataSource
{
    private func searchFor(str: String, inApp app: App) -> Bool
    {
        return app.name.lowercased().contains(str)
            || app.category.lowercased().contains(str)
            || app.artist.lowercased().contains(str)
            || app.summary.lowercased().contains(str)
    }
    
    private func shouldUseSearchResult() -> Bool
    {
        return delegate?.isSearching() ?? false
    }
    
    private func targetFreeAppList() -> [App]
    {
        return shouldUseSearchResult() ? freeAppsFiltered : freeApps
    }
    
    private func numOfAppsWithRatingInFreeAppsFiltered() -> Int
    {
        let filteredIds = freeAppsFiltered.map { $0.id }
        let ratingsAcquired = freeAppsWithRating.keys.filter { filteredIds.contains($0) }
        print("filtered free apps that already acquired rating: \(ratingsAcquired.count)")
        return ratingsAcquired.count
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
    
    func fetchFreeApps()
    {
        fetch(from: api.freeApp, ifSuccessful: { (json) in
            self.freeApps = self.parse(json: json)
            self.createFreeAppIndexMapping()
            self.fetchRating(fromIndex: 0)
        }) { (eror) in
            self.delegate?.failedGettingFreeApps()
        }
    }
    
    func filterData(withSearch search: String)
    {
        grossingAppsFiltered = grossingApps.filter { searchFor(str: search, inApp: $0) }
        self.delegate?.grossingAppDataUpdated()
        
        freeAppsFiltered = freeApps.filter { searchFor(str: search, inApp: $0) }
        self.delegate?.freeAppDataUpdated()
        
        print("search for \(search) ...\nfound \(grossingAppsFiltered.count) results in grossing App, \(freeAppsFiltered.count) results in free App")
    }
    
    private func createFreeAppIndexMapping()
    {
        for index in 0 ..< freeApps.count
        {
            let id = freeApps[index].id
            freeAppIndexMap[id] = index
        }
    }
    
    private func appIdsToSearch(fromIndex: Int) -> [String]
    {
        var ids: [String] = []
        var index = fromIndex
        
        let target = targetFreeAppList()
        while ids.count < DataSizeConfig.pageSize
            && index < target.count
        {
            let id = target[index].id
            if !freeAppsWithRating.keys.contains(id)
            {
                ids.append(id)
            }
            index += 1
        }
        return ids
    }
    
    private func fetchRating(fromIndex: Int)
    {
        do
        {
            let ids = appIdsToSearch(fromIndex: fromIndex)
            let url = try api.urlToSearch(ids: ids)
            fetch(from: url, ifSuccessful: { (json) in
                let newDetails = self.parseDetail(json: json)
                print("acquired \(newDetails.count) new ratings")
                for entry in newDetails
                {
                    self.freeAppsWithRating[entry.app.id] = entry
                }
                print("total app with ratings now: \(self.freeAppsWithRating.count)")
                self.delegate?.freeAppDataUpdated()
            }, ifFailed: { (error) in
                self.delegate?.failedGettingFreeApps()
            })
        }
        catch
        {
            // TODO: different call back for rating fetch?
            delegate?.failedGettingFreeApps()
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
    
    private func parseDetail(json: JSON) -> [AppWithRating]
    {
        var appsWithRating: [AppWithRating] = []
        let entries = json[detailKey.dataStart].arrayValue
        for entry in entries
        {
            let id = entry[detailKey.id].stringValue
            let rating = entry[detailKey.rating].doubleValue
            let count = entry[detailKey.count].stringValue
            if let index = freeAppIndexMap[id]
            {
                let app = freeApps[index]
                let appWithRating = AppWithRating(app: app,
                                                  rating: rating,
                                                  count: count)
                appsWithRating.append(appWithRating)
            }
            else
            {
                // TODO: handle this
                print("Error: cannot find index from mapping, id: \(id)")
            }
        }
        return appsWithRating
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
        return shouldUseSearchResult() ? grossingAppsFiltered.count : grossingApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GrossingAppCell.identifier, for: indexPath) as! GrossingAppCell
        cell.app = shouldUseSearchResult() ? grossingAppsFiltered[indexPath.row] : grossingApps[indexPath.row]
        return cell
    }
}

extension ITunesDataSource: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shouldUseSearchResult() ? numOfAppsWithRatingInFreeAppsFiltered() : freeAppsWithRating.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: FreeAppCell.identifier, for: indexPath) as! FreeAppCell
     
        let index = indexPath.row
        let target = targetFreeAppList()
        let id = target[index].id
        cell.index = index + 1
        if let appWithRating = freeAppsWithRating[id]
        {
            cell.appWithRating = appWithRating
        }
        
        if shouldFetchNextPage(currentIndex: index)
        {
            print("fetching more ratings ... current index \(index)")
            fetchRating(fromIndex: index + 1)
        }
        
        return cell
    }
    
    private func shouldFetchNextPage(currentIndex: Int) -> Bool
    {
        let target = targetFreeAppList()
        if currentIndex + 1 < target.count
        {
            let nextId = target[currentIndex + 1].id
            return !freeAppsWithRating.keys.contains(nextId)
        }
        return false
    }
}
