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
    
    @IBOutlet weak var winnerTextLabel: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(String(scoreKeeper.team1Score))
        team1Score.text = String(scoreKeeper.team1Score)
        team2Score.text = String(scoreKeeper.team2Score)
        if (scoreKeeper.team1Score > scoreKeeper.team2Score) {
            winnerTextLabel.text = "Team 1 Wins!!"
        } else {
            winnerTextLabel.text = "Team 2 Wins!!"
        }
    }
    
    @IBAction func goHome(sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
