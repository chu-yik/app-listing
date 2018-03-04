//
//  CellSlideInAnimationProvider.swift
//  AppListing
//
//  Created by MC on 4/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// animation provider for UITableView cell slide-in
class CellSlideInAnimationProvider
{
    enum Animation
    {
        static let initialTransform = CATransform3DMakeTranslation(80, 0, 0)
        static let duration = 0.2
        static let delay = 0.05
    }
    
    private var animated: [IndexPath] = []
    
    func animate(cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard !animated.contains(indexPath) else {
            return
        }
        
        cell.alpha = 0.0
        cell.layer.transform = Animation.initialTransform
        
        UIView.animate(withDuration: Animation.duration,
                       delay: Animation.delay,
                       options: .curveEaseInOut,
                       animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }) { (_) in
            self.animated.append(indexPath)
        }
    }
}
