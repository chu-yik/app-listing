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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        customiseSearchBar()
        
        createDataSource()
        
        createGrossingAppViewAsHeader()
        
        connectFreeAppView()
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
        let api = ITunesDataAPI(grossingAppSize: 10, freeAppSize: 30)
        let key = ITunesRssParsingKey()
        dataSource = ITunesDataSource(api: api, key: key)
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
extension MainViewController
{
    private func customiseSearchBar()
    {
        searchBar.placeholder = UIConfig.SearchBar.placeholder
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
        print("data available - refresh grossing app section")
        grossingAppView.reload()
    }
    
    func failedGettingGrossingApps()
    {
        print("failed getting grossing apps")
    }
    
    func freeAppDataUpdated()
    {
        print("data available - refresh free app table")
        freeAppTableView.reloadData()
    }
    
    func failedGettingFreeApps()
    {
        print("failed getting grossing apps")
    }
}
