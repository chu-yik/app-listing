//
//  UITableView.swift
//  AppListing
//
//  Created by MC on 20/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//
//  Modified from this gist by andreaantonioni
//  https://gist.github.com/andreaantonioni/0a8e7b07e7d62ade71a4a05bdb6367bf

import UIKit

extension UITableView
{
    func register<T: ReusableView>(_: T.Type) where T: NibLoadableView
    {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: ReusableView>(for indexPath: IndexPath) -> T
    {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
