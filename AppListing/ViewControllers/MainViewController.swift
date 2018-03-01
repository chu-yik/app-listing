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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        customiseSearchBar()
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

// MARK: - Search Bar
extension MainViewController
{
    private func customiseSearchBar()
    {
        searchBar.placeholder = UIConfig.SearchBar.placeholder
    }
}
