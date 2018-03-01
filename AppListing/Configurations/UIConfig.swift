//
//  UIConfig.swift
//  AppListing
//
//  Created by MC on 1/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// Constants for UI configuration
enum UIConfig
{
    /// configurations specific to the search bar
    enum SearchBar
    {
        static let placeholder = "搜尋"
    }
    /// configuration specific to the grossing app section
    enum Grossing
    {
        static let sectionHeight: CGFloat = 200.0
        static let cellHeight: CGFloat = 170.0
        static let labelHeight: CGFloat = 30.0
        static let labelTitle = "推介"
        static let labelFont = UIFont.boldSystemFont(ofSize: 20)
    }
}
