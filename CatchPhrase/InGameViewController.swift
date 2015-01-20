//
//  InGameViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 1/19/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class InGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: .Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
    }
    
    func exitGame() {
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
}
