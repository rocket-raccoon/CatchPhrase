//
//  NavBarUtilities.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 1/19/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import Foundation
import UIKit

class NavBarUtilities {
    
    //Disables the back button.  Adds an exit game bar button item that takes you to home screen
    func useExitGameBarItem(vc: UIViewController) {
        vc.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: .Plain, target: vc, action: Selector("exitGame"))
        vc.navigationItem.rightBarButtonItem = b
    }
    
}