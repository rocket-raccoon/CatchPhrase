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
    var returnHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Show the winner of the game
        displayWinner()
        createReturnHomeButton()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func displayWinner() {
        //Create a text label that shows which team won
        winnerTextLabel = UILabel(frame: CGRect())
        if scoreKeeper.team1Score > scoreKeeper.team2Score {
            winnerTextLabel.text = "Team 1 Wins!!"
        } else if scoreKeeper.team2Score > scoreKeeper.team1Score {
            winnerTextLabel.text = "Team 2 Wins!!"
        } else {
            winnerTextLabel.text = "It's a draw!"
        }
        winnerTextLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        winnerTextLabel.font = UIFont(name: winnerTextLabel.font.fontName, size: 30.0)
        winnerTextLabel.sizeToFit()
        view.addSubview(winnerTextLabel)
        //Center it horizontally
        let horizontalCenterConst = NSLayoutConstraint(item: winnerTextLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Vertically space it right below top of screen
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-75-[winnerTextLabel]", options: nil, metrics: nil, views: ["winnerTextLabel": winnerTextLabel])
        view.addConstraints(verticalSpacingConst)
    }
    
    func createReturnHomeButton() {
        returnHomeButton = StandardButtonCreator().createStandardButton("Return Home", enclosingView: view)
        //Horizontally center the button
        let horizontalCenterConst = NSLayoutConstraint(item: returnHomeButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Vertically space it right above the bottom edge of screen
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[returnHomeButton]-30-|", options: nil, metrics: nil, views: ["returnHomeButton": returnHomeButton])
        view.addConstraints(verticalSpacingConst)
        //Add the action to return home
        returnHomeButton.addTarget(self, action: Selector("returnHome"), forControlEvents: .TouchUpInside)
    }
    
    func returnHome() {
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
