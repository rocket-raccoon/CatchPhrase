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
        println("Audio starting to play")
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
        } else {
            audioPlayer.stop()
            pauseButton.setTitle("Resume", forState: UIControlState.Normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("endRound", sender: nil)
        }
    }
    
}






