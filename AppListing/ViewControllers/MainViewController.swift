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
    
    private var animationProvider = CellSlideInAnimationProvider()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        customiseSearchBar()
        
        createDataSource()
        
        createGrossingAppViewAsHeader()
        
        connectFreeAppView()
        
        createLoadingFreeAppIndicator()
        
        addRefreshControl()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}

// MARK: - Private helpers
extension MainViewController
{
    private func createDataSource()
    {
        let api = ITunesDataAPI(grossingAppSize: DataSizeConfig.grossing,
                                freeAppSize: DataSizeConfig.free)
        let key = ITunesRssParsingKey()
        let ratingKey = ITunesSearchParsingRatingKey()
        let parser = ITunesJsonParser(key: key, ratingKey: ratingKey)
        dataSource = ITunesDataSource(api: api, parser: parser)
        dataSource.delegate = self
        dataSource.fetchGrossingApps()
        dataSource.fetchFreeApps()
    }
    
    private func createGrossingAppViewAsHeader()
    {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: UIConfig.Grossing.sectionHeight)
        grossingAppView = GrossingAppView(frame: frame)
        grossingAppView.connectDataSource(dataSource: dataSource)
        grossingAppView.registerGrossingAppCell()
        freeAppTableView.tableHeaderView = grossingAppView
    }
    
    private func connectFreeAppView()
    {
        let nib = UINib(nibName: FreeAppCell.nibName, bundle: nil)
        freeAppTableView.register(nib, forCellReuseIdentifier: FreeAppCell.defaultReuseIdentifier)
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

// MARK: - refresh control
extension MainViewController
{
    private func addRefreshControl()
    {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: .refresh, for: .valueChanged)
        freeAppTableView.refreshControl = refreshControl
    }
    
    @objc func refresh()
    {
        dataSource.fetchGrossingApps()
        dataSource.fetchFreeApps()
    }
    
    private func stopDisplayingRefreshing()
    {
        freeAppTableView.refreshControl?.endRefreshing()
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
    
    private func showLoadingFreeAppIndicator(_ show: Bool)
    {
        freeAppTableView.tableFooterView?.isHidden = !show
    }
}

// MARK: - network error handling
extension MainViewController
{
    private func showNetworkErrorAlert(message: String, handler: ((UIAlertAction) -> Void)?)
    {
        let title = UIConfig.NetworkError.title
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: UIConfig.NetworkError.actionTitle,
                                         style: .cancel,
                                         handler: handler)
        alert.addAction(cancelAction)
        show(alert, sender: self)
    }
}

// MARK: - Conforming UITableViewDelegate
extension MainViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UIConfig.Free.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        animationProvider.animate(cell: cell, forRowAt: indexPath)
    }
}

// MARK: - Conforming AppDataSourceDelegate
extension MainViewController: AppDataSourceDelegate
{
    func grossingAppDataUpdated()
    {
        stopDisplayingRefreshing()
        grossingAppView.reload()
        
    }
    
    func failedGettingGrossingApps()
    {
        showNetworkErrorAlert(message: UIConfig.NetworkError.failedListingGrossingMessage) { _ in
            self.stopDisplayingRefreshing()
        }
    }
    
    func freeAppDataUpdated()
    {
        stopDisplayingRefreshing()
        showLoadingFreeAppIndicator(false)
        freeAppTableView.reloadData()
    }
    
    func failedGettingFreeApps()
    {
        showNetworkErrorAlert(message: UIConfig.NetworkError.failedListingFreeMessage) { _ in
            self.stopDisplayingRefreshing()
            self.showLoadingFreeAppIndicator(false)
        }
    }
    
    func failedGettingFreeAppsRatings()
    {

        showNetworkErrorAlert(message: UIConfig.NetworkError.failedGettingRatingsMessge) { _ in
            self.stopDisplayingRefreshing()
            self.showLoadingFreeAppIndicator(false)
        }
    }
    
    func isSearching() -> Bool
    {
        return currentSearch != nil
    }
    
    func grossingAppSizeUpdated(size: Int)
    {
        grossingAppView.showEmptyMessage(size == 0)
    }
    
    func isLoadingFreeApp(_ loading: Bool)
    {
        showLoadingFreeAppIndicator(loading)
    }
}

// MARK: - selector
fileprivate extension Selector
{
    static let refresh = #selector(MainViewController.refresh)
}
