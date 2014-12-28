//
//  HomePageViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/26/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "startGame") {
            var phraseBank = PhraseBank()
            var scoreKeeper = ScoreKeeper()
            var gameVC = segue.destinationViewController as GuessRoundViewController
            gameVC.phraseBank = phraseBank
            gameVC.scoreKeeper = scoreKeeper
        }
    }

}

