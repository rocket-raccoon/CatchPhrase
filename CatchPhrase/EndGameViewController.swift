//
//  EndGameViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {
    
    var scoreKeeper:ScoreKeeper!
    var winnerTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Show the winner of the game
        setupHeaderLabel()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func setupHeaderLabel() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
