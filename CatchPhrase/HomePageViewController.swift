//
//  HomePageViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/26/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var headerLabel: UILabel!
    var playButton: UIButton!
    var rulesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        setRulesButton()
        setPlayButton()
        setVerticalOrientation()
    }
    
    //Sets the vertical orientation of the views on the home screen
    func setVerticalOrientation() {
        var viewsDictionary = ["playButton": playButton, "rulesButton": rulesButton]
        var verticalOrientationConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[playButton]-[rulesButton]-50-|", options: nil, metrics: nil, views: viewsDictionary)
        view.addConstraints(verticalOrientationConstraint)
    }
    
    //Sets the header across the top of the screen displaying the name of the games
    func setHeader() {
        //Create the header
        var titleFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        headerLabel = UILabel(frame: titleFrame)
        headerLabel.text = "Catch Phrase!"
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 30)
        headerLabel.sizeToFit()
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
        //Center it horizontally
        var horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Place it just below the superview top
        var verticalPlacementConst = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 100)
        view.addConstraint(verticalPlacementConst)
    }
    
    //Creates a play button that starts the game of catch phrase
    func setPlayButton() {
        //Create the play button
        playButton = StandardButtonCreator().createStandardButton("Play", enclosingView: view)
        playButton.addTarget(self, action: Selector("goToSelectCategory"), forControlEvents: .TouchUpInside)
        //Set the width and horizontal center constraints on the play button
        var horizontalCenterConstraint = NSLayoutConstraint(item: playButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        view.addConstraint(horizontalCenterConstraint)
    }
    
    //Creates a rules button that takes the user to the rules screen
    func setRulesButton() {
        //Create the rules button
        rulesButton = StandardButtonCreator().createStandardButton("Rules", enclosingView: view)
        rulesButton.addTarget(self, action: Selector("showRules"), forControlEvents: .TouchUpInside)
        //Set the width and horizontal center constraints on the play button
        var horizontalCenterConstraint = NSLayoutConstraint(item: rulesButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        view.addConstraint(horizontalCenterConstraint)
    }
    
    func goToSelectCategory() {
        let categorySelectVC = CategorySelectViewController()
        navigationController?.pushViewController(categorySelectVC, animated: false)
    }
    
    func showRules() {
        let rulesVC = RulesPageViewController()
        navigationController?.pushViewController(rulesVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
    
    }

}

