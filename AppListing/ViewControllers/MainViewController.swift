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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customiseSearchBar()
        createGrossingAppView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    private func createGrossingAppView()
    {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: UIConfig.Grossing.sectionHeight)
        grossingAppView = GrossingAppView(frame: frame)
        freeAppTableView.tableHeaderView = grossingAppView
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
