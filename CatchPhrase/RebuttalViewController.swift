//
//  RebuttalViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class RebuttalViewController: UIViewController {
    
    var headerLabel: UILabel!
    var yesButton: UIButton!
    var noButton: UIButton!
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the views on the screens
        setupHeaderLabel()
        setupButtons()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
    }
    
    func setupHeaderLabel() {
        //Create the header
        headerLabel = UILabel(frame: CGRect())
        headerLabel.text = "Was there a successful rebuttal?"
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
        //Center the headerlabel horizontally
        let horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Place header just below top of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-75-[headerLabel]", options: nil, metrics: nil, views: ["headerLabel": headerLabel])
        view.addConstraints(verticalSpaceConst)
    }
    
    func setupButtons() {
        //Create both buttons
        yesButton = UIButton(frame: CGRect())
        noButton = UIButton(frame: CGRect())
        yesButton.setTitle("Yes", forState: .Normal)
        noButton.setTitle("No", forState: .Normal)
        yesButton.backgroundColor = UIColor.blueColor()
        noButton.backgroundColor = UIColor.blueColor()
        yesButton.layer.cornerRadius = 10
        noButton.layer.cornerRadius = 10
        yesButton.tag = 1
        noButton.tag = 2
        yesButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: UIControlEvents.TouchUpInside)
        noButton.addTarget(self, action: Selector("enterScore:"), forControlEvents: UIControlEvents.TouchUpInside)
        yesButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        noButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(yesButton)
        view.addSubview(noButton)
        //Set button widths proportional to screen width
        let widthConst1 = NSLayoutConstraint(item: yesButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0)
        let widthConst2 = NSLayoutConstraint(item: noButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0)
        view.addConstraint(widthConst1)
        view.addConstraint(widthConst2)
        //Horizontally center both buttons
        let horizontalCenterConst1 = NSLayoutConstraint(item: yesButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let horizontalCenterConst2 = NSLayoutConstraint(item: noButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst1)
        view.addConstraint(horizontalCenterConst2)
        //Vertically space buttons from bottom of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[yesButton]-[noButton]-30-|", options: nil, metrics: nil, views: ["yesButton": yesButton, "noButton": noButton])
        view.addConstraints(verticalSpaceConst)
    }
    
    func enterScore(sender: UIButton) {
        let didScore = sender.tag
        if didScore == 1 {
            scoreKeeper.addRebuttal()
        }
        var currentStandingsVC = CurrentStandingsViewController()
        currentStandingsVC.scoreKeeper = scoreKeeper
        currentStandingsVC.phraseBank = phraseBank
        navigationController?.pushViewController(currentStandingsVC, animated: false)
    }
    
    func exitGame() {
        performSegueWithIdentifier("exitGame", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
