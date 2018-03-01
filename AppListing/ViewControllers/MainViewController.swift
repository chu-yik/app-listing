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
    
    private var grossingAppCollectionView: UICollectionView! = nil
    
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: UIConfig.Grossing.sectionHeight)
        
        grossingAppCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        grossingAppCollectionView.backgroundColor = .green
        grossingAppCollectionView.isSpringLoaded = true
        grossingAppCollectionView.allowsSelection = false
        grossingAppCollectionView.showsHorizontalScrollIndicator = false
        
        freeAppTableView.tableHeaderView = grossingAppCollectionView
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
