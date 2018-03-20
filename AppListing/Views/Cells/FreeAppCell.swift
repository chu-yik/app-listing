//
//  FreeAppCell.swift
//  AppListing
//
//  Created by MC on 2/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit
import Cosmos

/// Cell for displaying Free App with rating info
class FreeAppCell: UITableViewCell
{
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        configureImageView()
    }
    
    var index: Int? {
        didSet {
            if let index = index
            {
                indexLabel.text = "\(index)"
                let type = AppIconCropping.forIndex(index: index)
                configureImageCropping(type: type)
            }
        }
    }
    
    var app: App? {
        didSet {
            if let app = app
            {
                nameLabel.text = app.name
                categoryLabel.text = app.category
                updateImageFrom(app.imageUrl)
            }
        }
    }
    
    var appRating: AppRating? {
        didSet {
            if let appRating = appRating
            {
                update(averageRating: appRating.rating,
                       ratingCount: appRating.count)
            }
        }
    }
    
    private func updateImageFrom(_ imageUrl: String)
    {
        if let url = URL(string: imageUrl)
        {
            appImageView.kf.indicatorType = .activity
            appImageView.kf.setImage(with: url)
        }
    }
    
    private func configureImageView()
    {
        appImageView.contentMode = .scaleAspectFit
        appImageView.clipsToBounds = true
    }
    
    private func configureImageCropping(type: AppIconCropping)
    {
        appImageView.layer.cornerRadius = type.cornerRadisu(sideLength: appImageView.frame.width)
        appImageView.layer.borderWidth = UIConfig.AppImage.borderWidth
        appImageView.layer.borderColor = UIConfig.AppImage.borderColor
    }
    
    private func update(averageRating: Double, ratingCount: String)
    {
        ratingView.rating = averageRating
        ratingView.text = "(\(ratingCount.isEmpty ? "0" : ratingCount))"
    }
}
