//
//  ReusableView.swift
//  AppListing
//
//  Created by MC on 20/3/2018.
//
//  Credit to this gist by andreaantonioni:
//  https://gist.github.com/andreaantonioni/0a8e7b07e7d62ade71a4a05bdb6367bf

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
