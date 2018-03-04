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
    
    var freeAppRatings: [String : AppRating] = [:]
    
    private var api: DataAPIProtocol
    private var parser: JsonParserProtocol
    
    private var fetchingInProgress = false
    
    init(api: DataAPIProtocol, parser: JsonParserProtocol)
    {
        self.api = api
        self.parser = parser
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
        let ratingsAcquired = freeAppRatings.keys.filter { filteredIds.contains($0) }
        print("filtered free apps that already acquired rating: \(ratingsAcquired.count)")
        return ratingsAcquired.count
    }
}

extension ITunesDataSource: AppDataSourceProtocol
{
    func fetchGrossingApps()
    {
        fetch(from: api.grossingApp, ifSuccessful: { (json) in
            self.grossingApps = self.parser.parse(json: json)
            self.delegate?.grossingAppDataUpdated()
        }) { (eror) in
            self.delegate?.failedGettingGrossingApps()
        }
    }
    
    func fetchFreeApps()
    {
        delegate?.isLoadingFreeApp(true)
        fetch(from: api.freeApp, ifSuccessful: { (json) in
            self.freeApps = self.parser.parse(json: json)
            self.fetchRating()
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
    
    private func appIdsToSearch() -> [String]
    {
        var ids: [String] = []
        var index = 0
        
        let target = targetFreeAppList()
        while ids.count < DataSizeConfig.pageSize
            && index < target.count
        {
            let id = target[index].id
            if !freeAppRatings.keys.contains(id)
            {
                ids.append(id)
            }
            index += 1
        }
        return ids
    }
    
    private func fetchRating()
    {
        guard !fetchingInProgress else {
            return
        }
        do
        {
            delegate?.isLoadingFreeApp(true)
            let ids = appIdsToSearch()
            let url = try api.urlToSearch(ids: ids)
            fetchingInProgress = true
            fetch(from: url, ifSuccessful: { (json) in
                let newRatings = self.parser.parseRating(json: json)
                print("acquired \(newRatings.count) new ratings")
                for rating in newRatings
                {
                    self.freeAppRatings[rating.id] = rating
                }
                print("total app with ratings now: \(self.freeAppRatings.count)")
                self.fetchingInProgress = false
                self.delegate?.freeAppDataUpdated()
            }, ifFailed: { (error) in
                self.fetchingInProgress = false
                self.delegate?.failedGettingFreeAppsRatings()
            })
        }
        catch
        {
            delegate?.failedGettingFreeAppsRatings()
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
}

extension ITunesDataSource: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count = shouldUseSearchResult() ? grossingAppsFiltered.count : grossingApps.count
        delegate?.grossingAppSizeUpdated(size: count)
        return count
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
        return shouldUseSearchResult() ? numOfAppsWithRatingInFreeAppsFiltered() : freeAppRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: FreeAppCell.identifier, for: indexPath) as! FreeAppCell
     
        let index = indexPath.row
        cell.index = index + 1
        
        let target = targetFreeAppList()
        let id = target[index].id
        
        if let appRating = freeAppRatings[id]
        {
            cell.app = target[index]
            cell.appRating = appRating
            
            if shouldFetchNextPage(currentIndex: index)
            {
                print("fetching more rating ... after index \(index)")
                fetchRating()
            }
        }
        else
        {
            print("fetching missing rating ... at index \(index)")
            fetchRating()
        }
        
        return cell
    }
    
    private func shouldFetchNextPage(currentIndex: Int) -> Bool
    {
        let target = targetFreeAppList()
        guard target.count > currentIndex + 1 else {
            return false
        }

        let nextId = target[currentIndex + 1].id
        return !freeAppRatings.keys.contains(nextId)
    }
}
