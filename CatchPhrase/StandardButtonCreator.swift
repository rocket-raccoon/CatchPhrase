//
//  StandardButtonCreator.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 1/19/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import Foundation
import UIKit

class StandardButtonCreator {
    
    func createStandardButton(buttonTitle: NSString, enclosingView: UIView) -> UIButton {
        //Create a standard button
        var button = UIButton(frame: CGRect())
        button.setTitle(buttonTitle, forState: .Normal)
        button.backgroundColor = .blueColor()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.layer.cornerRadius = 10
        enclosingView.addSubview(button)
        //Set the width and height constraints on the button
        let widthConst = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: enclosingView, attribute: .Width, multiplier: 0.8, constant: 0)
        let heightConst = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 60)
        enclosingView.addConstraint(widthConst)
        enclosingView.addConstraint(heightConst)
        return button
    }
    
}
