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
    
    @IBOutlet weak var phraseTextView: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Put up the phrase on screen
        let phrase = phraseBank.getNextPhrase()
        phraseTextView.text = phrase
        phraseTextView.font = UIFont(name: phraseTextView.font.fontName, size: 20)
        //Set up the audio for the countdown timer
        let filePath = NSBundle.mainBundle().pathForResource("countdown", ofType: ".mp3")
        let filePathUrl = NSURL(fileURLWithPath: filePath!)
        audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.play()
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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pauseCountdown(sender: UIButton) {
        let state = pauseButton.titleLabel!.text
        if (state == "Resume") {
            audioPlayer.stop()
            audioPlayer.play()
            pauseButton.setTitle("Pause", forState: UIControlState.Normal)
            pauseButton.backgroundColor = UIColor.redColor();
        } else {
            audioPlayer.stop()
            pauseButton.setTitle("Resume", forState: UIControlState.Normal)
            pauseButton.backgroundColor = UIColor.greenColor()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("endRound", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "endRound") {
            var endRoundVC = segue.destinationViewController as EndRoundViewController
            endRoundVC.phraseBank = phraseBank
            endRoundVC.scoreKeeper = scoreKeeper
        }
    }
    
    @IBAction func skipPhrase(sender: UIButton) {
        if scoreKeeper.skipsLeft() {
            let phrase = phraseBank.getNextPhrase()
            phraseTextView.text = phrase
            scoreKeeper.curSkips += 1
        } else {
            println("No more skips for this round")
        }
    }
    
    @IBAction func getNextPhrase(sender: UIButton) {
        let phrase = phraseBank.getNextPhrase()
        phraseTextView.text = phrase
        scoreKeeper.curSkips = 0
    }
    
}













