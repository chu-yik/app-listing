//
//  FreeAppCell.swift
//  AppListing
//
//  Created by MC on 2/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit
import Cosmos

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
    
    var app: App? {
        didSet {
            if let app = app
            {
                nameLabel.text = app.name
                categoryLabel.text = app.category
                updateImageFrom(app.imageUrl)
                // TODO: ratings
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
}
