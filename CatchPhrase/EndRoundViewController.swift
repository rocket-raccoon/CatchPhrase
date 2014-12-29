//
//  EndRoundViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/27/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class EndRoundViewController: UIViewController {
    
    var phraseBank:PhraseBank!
    var scoreKeeper:ScoreKeeper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nameTeam2Winner(sender: UIButton) {
        scoreKeeper.incrementTeam2Score()
        performSegueWithIdentifier("goToRebuttal", sender: nil)
    }
    
    @IBAction func nameTeam1Winner(sender: UIButton) {
        scoreKeeper.incrementTeam1Score()
        performSegueWithIdentifier("goToRebuttal", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "goToRebuttal") {
            var rebuttalVC = segue.destinationViewController as RebuttalViewController
            rebuttalVC.scoreKeeper = scoreKeeper
            rebuttalVC.phraseBank = phraseBank
        }
    }
}
