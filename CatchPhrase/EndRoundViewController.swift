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
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
    }
    
    func exitGame() {
        performSegueWithIdentifier("exitGame", sender: nil)
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
