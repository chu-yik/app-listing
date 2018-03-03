//
//  MainViewController.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var freeAppTableView: UITableView!
    
    private var grossingAppView: GrossingAppView! = nil
    private var dataSource: AppDataSourceProtocol! = nil
    private var currentSearch: String? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        customiseSearchBar()
        
        createDataSource()
        
        createGrossingAppViewAsHeader()
        
        connectFreeAppView()
        
        createLoadingFreeAppIndicator()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    private func createGrossingAppViewAsHeader()
    {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: UIConfig.Grossing.sectionHeight)
        grossingAppView = GrossingAppView(frame: frame)
        grossingAppView.connectDataSource(dataSource: dataSource)
        grossingAppView.registerGrossingAppCell()
        freeAppTableView.tableHeaderView = grossingAppView
    }
    
    private func createDataSource()
    {
        let api = ITunesDataAPI(grossingAppSize: DataSizeConfig.grossing,
                                freeAppSize: DataSizeConfig.free)
        let key = ITunesRssParsingKey()
        let detailKey = ITunesSearchParsingDetailKey()
        dataSource = ITunesDataSource(api: api, key: key, detailKey: detailKey)
        dataSource.delegate = self
        dataSource.fetchGrossingApps()
        dataSource.fetchFreeApps()
    }
    
    private func connectFreeAppView()
    {
        let nib = UINib(nibName: FreeAppCell.identifier, bundle: nil)
        freeAppTableView.register(nib, forCellReuseIdentifier: FreeAppCell.identifier)
        freeAppTableView.dataSource = dataSource
        freeAppTableView.delegate = self
    }
}

// MARK: - Search Bar
extension MainViewController: UISearchBarDelegate
{
    private func customiseSearchBar()
    {
        searchBar.placeholder = UIConfig.SearchBar.placeholder
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.autocorrectionType = .no
    }
    
    private func hideSearchBarKeyBoard()
    {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        hideSearchBarKeyBoard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        hideSearchBarKeyBoard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        let newSearch = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        
        guard newSearch != currentSearch else
        {
            return
        }
    
        guard newSearch.count > 0 else
        {
            if currentSearch != nil
            {
                currentSearch = nil
                grossingAppView.reload()
                freeAppTableView.reloadData()
            }
            return
        }
        
        currentSearch = newSearch
        dataSource.filterData(withSearch: newSearch)
    }
}

// MARK: - loading indicator
extension MainViewController
{
    private func createLoadingFreeAppIndicator()
    {
        let frame = CGRect(x: 0, y: 0,
                           width: freeAppTableView.bounds.width,
                           height: UIConfig.LoadingIndicator.height)
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicatorView.frame = frame
        indicatorView.startAnimating()
        freeAppTableView.tableFooterView = indicatorView
    }
    
    func showLoadingFreeAppIndicator(_ show: Bool)
    {
        freeAppTableView.tableFooterView?.isHidden = !show
    }
}

// MARK: - Conforming UITableViewDelegate
extension MainViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UIConfig.Free.cellHeight
    }
}

// MARK: - Conforming AppDataSourceDelegate
extension MainViewController: AppDataSourceDelegate
{
    func grossingAppDataUpdated()
    {
        grossingAppView.reload()
    }
    
    func failedGettingGrossingApps()
    {
        print("failed getting grossing apps")
    }
    
    func freeAppDataUpdated()
    {
        freeAppTableView.reloadData()
    }
    
    func failedGettingFreeApps()
    {
        print("failed getting free apps")
    }
    
    func failedGettingFreeAppsRatings()
    {
        print("failed getting ratings for free apps")
    }
    
    func isSearching() -> Bool
    {
        return currentSearch != nil
    }
    
    func grossingAppSizeUpdated(size: Int)
    {
        grossingAppView.showEmptyMessage(size == 0)
    }
}
