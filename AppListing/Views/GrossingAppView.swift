//
//  GrossingAppView.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// Custom container view that holds a UILabel and a UICollectionView to display grossing Apps
class GrossingAppView: UIView
{
    private var headerLabel: UILabel!
    private var grossingAppCollectionView: UICollectionView!
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: UIConfig.Grossing.spacing,
                                           bottom: 0, right: UIConfig.Grossing.spacing)
        layout.minimumLineSpacing = UIConfig.Grossing.spacing
        return layout
    }()
    
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
    
    func connectDataSource(dataSource: AppDataSourceProtocol)
    {
        grossingAppCollectionView.dataSource = dataSource
    }
    
    func registerGrossingAppCell()
    {
        let nib = UINib(nibName: GrossingAppCell.identifier, bundle: nil)
        grossingAppCollectionView.register(nib, forCellWithReuseIdentifier: GrossingAppCell.identifier)
    }
    
    func reload()
    {
        grossingAppCollectionView.reloadData()
    }
    
    func showEmptyMessage(_ show: Bool)
    {
        grossingAppCollectionView.backgroundView?.isHidden = !show
    }
    
    private func addHeaderLabel()
    {
        headerLabel = UILabel(frame: CGRect.zero)
        headerLabel.text = UIConfig.Grossing.labelTitle
        headerLabel.font = UIConfig.Grossing.labelFont
        addSubview(headerLabel)
        addHeaderLabelConstraints()
    }
    
    private func addHeaderLabelConstraints()
    {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: UIConfig.Grossing.spacing)
        let trailing = NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -UIConfig.Grossing.spacing)
        let top = NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let fixHeight = NSLayoutConstraint(item: headerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIConfig.Grossing.labelHeight)
        self.addConstraints([leading, trailing, top, fixHeight])
    }
    
    private func addCollectionView()
    {
        grossingAppCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        grossingAppCollectionView.backgroundColor = .white
        grossingAppCollectionView.isSpringLoaded = true
        grossingAppCollectionView.allowsSelection = false
        grossingAppCollectionView.showsHorizontalScrollIndicator = false
        grossingAppCollectionView.delegate = self
        grossingAppCollectionView.backgroundView = EmptyMessageView(frame: CGRect.zero)
        addSubview(grossingAppCollectionView)
        addCollectionViewConstraints()
    }
    
    private func addCollectionViewConstraints()
    {
        grossingAppCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: grossingAppCollectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: grossingAppCollectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: grossingAppCollectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let fixHeight = NSLayoutConstraint(item: grossingAppCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIConfig.Grossing.cellHeight)
        self.addConstraints([leading, trailing, bottom, fixHeight])
    }
}

extension GrossingAppView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConfig.Grossing.cellWidth,
                      height: UIConfig.Grossing.cellHeight)
    }
}
