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
        let api = ITunesDataAPI(grossingAppSize: 10, freeAppSize: 100)
        let key = ITunesRssParsingKey()
        dataSource = ITunesDataSource(api: api, key: key)
        dataSource.delegate = self
        dataSource.fetchGrossingApps()
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
}
