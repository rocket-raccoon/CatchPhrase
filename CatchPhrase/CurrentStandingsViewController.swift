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
        team1ScoreTextField.text = String(scoreKeeper.team1Score)
        team2ScoreTextField.text = String(scoreKeeper.team2Score)
        roundTextField.text = String(scoreKeeper.currentRound)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startNextRound(sender: UIButton) {
        scoreKeeper.currentRound += 1
        performSegueWithIdentifier("startNextRound", sender: nil)
    }
    
    @IBAction func endGame(sender: UIButton) {
        performSegueWithIdentifier("endGame", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "startNextRound") {
            var roundVC = segue.destinationViewController as GuessRoundViewController
            roundVC.scoreKeeper = scoreKeeper
            roundVC.phraseBank = phraseBank
        } else if (segue.identifier == "endGame") {
            var endGameVC = segue.destinationViewController as EndGameViewController
            endGameVC.scoreKeeper = scoreKeeper
        }
    }
    
}




