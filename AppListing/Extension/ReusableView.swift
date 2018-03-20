//
//  ReusableView.swift
//  AppListing
//
//  Created by MC on 20/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// protocol to provide an implementation of default reuse identifier
protocol ReusableView: class
{
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView
{
    static var defaultReuseIdentifier: String
    {
        return NSStringFromClass(self)
    }
}

/// making UICollectionViewCell conform to ReusableView
extension UICollectionViewCell: ReusableView {}
/// making UITableViewCell conform to ReusableView
extension UITableViewCell: ReusableView {}
