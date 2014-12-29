//
//  CurrentStandingsViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CurrentStandingsViewController: UIViewController {
    
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    
    @IBOutlet weak var team1ScoreTextField: UITextField!
    @IBOutlet weak var team2ScoreTextField: UITextField!
    @IBOutlet weak var roundTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        team1ScoreTextField.text = "\(scoreKeeper.team1Score)"
        team2ScoreTextField.text = "\(scoreKeeper.team2Score)"
        roundTextField.text = "\(scoreKeeper.currentRound) / \(scoreKeeper.totalRounds)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startNextRound(sender: UIButton) {
        scoreKeeper.currentRound += 1
        performSegueWithIdentifier("startNextRound", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "startNextRound") {
            var roundVC = segue.destinationViewController as GuessRoundViewController
            roundVC.scoreKeeper = scoreKeeper
            roundVC.phraseBank = phraseBank
        }
    }
    
}




