//
//  AppImageCropping.swift
//  AppListing
//
//  Created by MC on 3/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//
import UIKit

enum AppIconCropping
{
    case circle
    case roundCorner
    
    static func forIndex(index: Int) -> AppIconCropping
    {
        let isOdd = index % 2 > 0
        return isOdd ? .roundCorner : .circle
    }
    
    func cornerRadisu(sideLength: CGFloat) -> CGFloat
    {
        switch self
        {
        case .circle:
            return sideLength / 2.0
        case .roundCorner:
            return sideLength / 4.0
        }
    }
}
