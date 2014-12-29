//
//  RebuttalViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class RebuttalViewController: UIViewController {
    
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addRebuttal(sender: UIButton) {
        scoreKeeper.addRebuttal()
        performSegueWithIdentifier("showCurrentStandings", sender: nil)
    }
    
    @IBAction func dontAddRebuttal(sender: UIButton) {
        performSegueWithIdentifier("showCurrentStandings", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showCurrentStandings") {
            var standingsVC = segue.destinationViewController as CurrentStandingsViewController
            standingsVC.scoreKeeper = scoreKeeper
            standingsVC.phraseBank = phraseBank
        }
    }
    
}
