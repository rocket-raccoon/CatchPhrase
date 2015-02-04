//
//  EndRoundViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/27/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class EndRoundViewController: InGameViewController {
    
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
    }
    
    func setupHeaderLabel() {
        //Create the header
        headerLabel = UILabel(frame: CGRect())
        headerLabel.text = "Which team scored?"
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 30.0)
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
        //Center the headerlabel horizontally
        let horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Place header just below top of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[headerLabel]", options: nil, metrics: nil, views: ["headerLabel": headerLabel, "topLayoutGuide": topLayoutGuide])
        view.addConstraints(verticalSpaceConst)
    }
    
    func setupTeamSelectionButtons() {
        //Create both buttons
        teamOneButton = StandardButtonCreator().createStandardButton("Team 1", enclosingView: view)
        teamTwoButton = StandardButtonCreator().createStandardButton("Team 2", enclosingView: view)
        teamOneButton.tag = 1
        teamTwoButton.tag = 2
        teamOneButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: .TouchUpInside)
        teamTwoButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: .TouchUpInside)
        //Horizontally center both buttons
        let horizontalCenterConst1 = NSLayoutConstraint(item: teamOneButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let horizontalCenterConst2 = NSLayoutConstraint(item: teamTwoButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst1)
        view.addConstraint(horizontalCenterConst2)
        //Vertically space buttons from bottom of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[teamOneButton]-[teamTwoButton]-30-|", options: nil, metrics: nil, views: ["teamOneButton": teamOneButton, "teamTwoButton": teamTwoButton])
        view.addConstraints(verticalSpaceConst)
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
