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
        static let sectionHeight: CGFloat = 240.0
        static let cellWidth: CGFloat = 90.0
        static let cellHeight: CGFloat = 180.0
        static let labelHeight: CGFloat = sectionHeight - cellHeight
        static let labelTitle = "推介"
        static let labelFont = UIFont.boldSystemFont(ofSize: 24)
        static let spacing: CGFloat = 15.0
    }
    /// configuration specific to the free app section
    enum Free
    {
        static let cellHeight: CGFloat = 100.0
    }
    /// configuration for App UIImageView
    enum AppImage
    {
        static let borderWidth: CGFloat = 0.2
        static let borderColor = UIColor.gray.cgColor
    }
    /// configuration for displaying empty message
    enum EmptyMessage
    {
        static let labelText = "沒有可顯示項目"
        static let labelFont = UIFont.boldSystemFont(ofSize: 20)
        static let labelColor = UIColor.gray
    }
    /// configuration for loading indicator
    enum LoadingIndicator
    {
        static let height: CGFloat = 30.0
    }
}
