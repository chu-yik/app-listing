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
    static let identifier = "FreeAppCell"
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    var index: Int? {
        didSet {
            if let index = index
            {
                indexLabel.text = "\(index)"
                configureImageView()
            }
        }
    }
    
    var appWithRating: AppWithRating? {
        didSet {
            if let appWithRating = appWithRating
            {
                nameLabel.text = appWithRating.app.name
                categoryLabel.text = appWithRating.app.category
                updateImageFrom(appWithRating.app.imageUrl)
                update(averageRating: appWithRating.rating,
                       ratingCount: appWithRating.count)
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
        // TODO: round or circle clipping here
        appImageView.clipsToBounds = true
    }
    
    private func update(averageRating: Double, ratingCount: String)
    {
        ratingView.rating = averageRating
        ratingView.text = "(\(ratingCount))"
    }
}