//
//  NibLoadableView.swift
//  AppListing
//
//  Created by MC on 20/3/2018.
//
//  Credit to this gist by andreaantonioni:
//  https://gist.github.com/andreaantonioni/0a8e7b07e7d62ade71a4a05bdb6367bf

import UIKit

/// protocol to provide an implementation of getting nib Name from class
protocol NibLoadableView: class
{
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView
{
    static var nibName: String
    {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

/// making GrossingAppCell conform to NibLoadableView
extension GrossingAppCell: NibLoadableView {}
/// making FreeAppCell conform to NibLoadableView
extension FreeAppCell: NibLoadableView {}
