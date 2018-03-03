//
//  GrossingAppCell.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit
import Kingfisher

/// Cell for displaying Grossing App
class GrossingAppCell: UICollectionViewCell
{
    static let identifier = "GrossingAppCell"
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        configureImageView()
        configureImageCropping()
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
    
    private func configureImageCropping()
    {
        let type = AppIconCropping.roundCorner
        appImageView.layer.cornerRadius = type.cornerRadisu(sideLength: appImageView.frame.width)
        appImageView.layer.borderWidth = UIConfig.AppImage.borderWidth
        appImageView.layer.borderColor = UIConfig.AppImage.borderColor
    }
}
