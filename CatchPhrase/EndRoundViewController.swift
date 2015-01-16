//
//  EndRoundViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/27/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class EndRoundViewController: UIViewController {
    
    var headerLabel: UILabel!
    var teamOneButton: UIButton!
    var teamTwoButton: UIButton!
    
    var phraseBank:PhraseBank!
    var scoreKeeper:ScoreKeeper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Draw the views on the screen
        setupHeaderLabel()
        setupTeamSelectionButtons()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
    }
    
    func setupHeaderLabel() {
        //Create the header
        var headerLabelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.text = "Which team scored?"
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
        //Center the headerlabel horizontally
        let horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Place header just below top of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-75-[headerLabel]", options: nil, metrics: nil, views: ["headerLabel": headerLabel])
        view.addConstraints(verticalSpaceConst)
    }
    
    func setupTeamSelectionButtons() {
        //Create both buttons
        var buttonFrame = CGRect()
        teamOneButton = UIButton(frame: buttonFrame)
        teamTwoButton = UIButton(frame: buttonFrame)
        teamOneButton.setTitle("Team 1", forState: .Normal)
        teamTwoButton.setTitle("Team 2", forState: .Normal)
        teamOneButton.backgroundColor = UIColor.blueColor()
        teamTwoButton.backgroundColor = UIColor.blueColor()
        teamOneButton.layer.cornerRadius = 10
        teamTwoButton.layer.cornerRadius = 10
        teamOneButton.tag = 1
        teamTwoButton.tag = 2
        teamOneButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: UIControlEvents.TouchUpInside)
        teamTwoButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: UIControlEvents.TouchUpInside)
        teamOneButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        teamTwoButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(teamOneButton)
        view.addSubview(teamTwoButton)
        //Set button widths proportional to screen width
        let widthConst1 = NSLayoutConstraint(item: teamOneButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0)
        let widthConst2 = NSLayoutConstraint(item: teamTwoButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0)
        view.addConstraint(widthConst1)
        view.addConstraint(widthConst2)
        //Horizontally center both buttons
        let horizontalCenterConst1 = NSLayoutConstraint(item: teamOneButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let horizontalCenterConst2 = NSLayoutConstraint(item: teamTwoButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst1)
        view.addConstraint(horizontalCenterConst2)
        //Vertically space buttons from bottom of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[teamOneButton]-[teamTwoButton]-30-|", options: nil, metrics: nil, views: ["teamOneButton": teamOneButton, "teamTwoButton": teamTwoButton])
        view.addConstraints(verticalSpaceConst)
    }
    
    func exitGame() {
        performSegueWithIdentifier("exitGame", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func enterScore(sender: UIButton) {
        let winner = sender.tag
        if winner == 1 {
            scoreKeeper.incrementTeam1Score()
        } else {
            scoreKeeper.incrementTeam2Score()
        }
        var rebuttalVC = RebuttalViewController()
        rebuttalVC.scoreKeeper = scoreKeeper
        rebuttalVC.phraseBank = phraseBank
        navigationController?.pushViewController(rebuttalVC, animated: false)
    }
    
}
