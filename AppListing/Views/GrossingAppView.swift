//
//  GrossingAppView.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

class GrossingAppView: UIView
{
    private var grossingAppCollectionView: UICollectionView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addHeaderLabel()
        addCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addHeaderLabel()
    {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: UIConfig.Grossing.labelHeight)
        let headerLabel = UILabel(frame: frame)
        headerLabel.text = UIConfig.Grossing.labelTitle
        addSubview(headerLabel)
    }
    
    private func addCollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let frame = CGRect(x: 0, y: UIConfig.Grossing.labelHeight, width: self.frame.width, height: UIConfig.Grossing.cellHeight)
        
        grossingAppCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        grossingAppCollectionView.backgroundColor = .green
        grossingAppCollectionView.isSpringLoaded = true
        grossingAppCollectionView.allowsSelection = false
        grossingAppCollectionView.showsHorizontalScrollIndicator = false
        
        addSubview(grossingAppCollectionView)
    }
}
