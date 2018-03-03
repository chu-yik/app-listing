//
//  EmptyMessageView.swift
//  AppListing
//
//  Created by MC on 3/3/2018.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

/// custom view for displaying a message for empty collection
class EmptyMessageView: UIView
{
    private var messageLabel: UILabel!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addMessageLabel()
    {
        messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.text = UIConfig.EmptyMessage.labelText
        messageLabel.font = UIConfig.EmptyMessage.labelFont
        messageLabel.textColor = UIConfig.EmptyMessage.labelColor
        messageLabel.textAlignment = .center
        self.addSubview(messageLabel)
        addMessageLabelConstraints()
    }
    
    private func addMessageLabelConstraints()
    {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: messageLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraints([leading, trailing, top, bottom])
    }
}
