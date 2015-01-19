//
//  GuessRoundViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/26/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit
import AVFoundation

class GuessRoundViewController: UIViewController, AVAudioPlayerDelegate {
    
    var phraseBank:PhraseBank!
    var scoreKeeper:ScoreKeeper!
    var audioPlayer:AVAudioPlayer!
    
    var headerLabel: UILabel!
    var phraseLabel: UILabel!
    var pauseButton: UIButton!
    var skipButton: UIButton!
    var nextButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        //Put the new phrase on the screen
        let phrase = phraseBank.getNextPhrase()
        phraseLabel.text = phrase
        phraseLabel.font = UIFont(name: phraseLabel.font.fontName, size: 20)
        //Start the countdown timer
        let filePath = NSBundle.mainBundle().pathForResource("countdown", ofType: ".mp3")
        let filePathUrl = NSURL(fileURLWithPath: filePath!)
        audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up the views on the screen
        setupHeaderLabel()
        setupPhraseLabel()
        setupPauseButton()
        setupSkipButton()
        setupNextButton()
        horizontallyCenterViews([skipButton, nextButton, pauseButton, headerLabel])
        verticallyOrientViews()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
    }
    
    func setupHeaderLabel() {
        //Create the header label
        var headerLabelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.text = "Your phrase is:"
        headerLabel.sizeToFit()
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
    }
    
    func setupPhraseLabel() {
        //Create the phrase label
        var phraseLabelFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 500)
        phraseLabel = UILabel(frame: phraseLabelFrame)
        phraseLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        phraseLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(phraseLabel)
        //Set width equal to screen width
        let widthConst = NSLayoutConstraint(item: phraseLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        view.addConstraint(widthConst)
    }
    
    func setupPauseButton() {
        //Create the pause button
        pauseButton = StandardButtonCreator().createStandardButton("Pause", enclosingView: view)
        pauseButton.addTarget(self, action: Selector("pauseGame"), forControlEvents: .TouchUpInside)
    }
    
    func setupSkipButton() {
        //Create the skip button
        skipButton = StandardButtonCreator().createStandardButton("Skip", enclosingView: view)
        skipButton.addTarget(self, action: Selector("skipPhrase"), forControlEvents: .TouchUpInside)
    }
    
    func setupNextButton() {
        //Create the next button
        nextButton = StandardButtonCreator().createStandardButton("Next", enclosingView: view)
        nextButton.addTarget(self, action: Selector("nextPhrase"), forControlEvents: .TouchUpInside)
    }
    
    func horizontallyCenterViews(viewsToCenter: [UIView]) {
        for v in viewsToCenter {
            let horizontalCenterConst = NSLayoutConstraint(item: v, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
            view.addConstraint(horizontalCenterConst)
        }
    }
    
    func verticallyOrientViews() {
        //Vertically align header and phrase labels just below top of screen
        var labelsDictionary = ["headerLabel": headerLabel, "phraseLabel": phraseLabel]
        var labelsVerticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-75-[headerLabel]-[phraseLabel]", options: nil, metrics: nil, views: labelsDictionary)
        view.addConstraints(labelsVerticalConst)
        //Vertically align buttons just above bottom of screen
        var buttonsDictionary = ["pauseButton": pauseButton, "skipButton": skipButton, "nextButton": nextButton]
        var buttonsVerticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[pauseButton]-[skipButton]-[nextButton]-30-|", options: nil, metrics: nil, views: buttonsDictionary)
        view.addConstraints(buttonsVerticalConst)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pauseGame() {
        let state = pauseButton.titleLabel!.text
        if (state == "Resume") {
            audioPlayer.stop()
            audioPlayer.play()
            pauseButton.setTitle("Pause", forState: UIControlState.Normal)
        } else {
            audioPlayer.stop()
            pauseButton.setTitle("Resume", forState: UIControlState.Normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            var endRoundVC = EndRoundViewController()
            endRoundVC.phraseBank = phraseBank
            endRoundVC.scoreKeeper = scoreKeeper
            navigationController?.pushViewController(endRoundVC, animated: false)
        }
    }
    
    func skipPhrase() {
        if scoreKeeper.skipsLeft() {
            let phrase = phraseBank.getNextPhrase()
            phraseLabel.text = phrase
            scoreKeeper.curSkips += 1
        } else {
            println("No more skips for this round")
        }
    }
    
    func nextPhrase() {
        let phrase = phraseBank.getNextPhrase()
        phraseLabel.text = phrase
        scoreKeeper.curSkips = 0
    }
    
}













