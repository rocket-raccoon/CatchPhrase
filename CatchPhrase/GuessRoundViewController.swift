//
//  GuessRoundViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/26/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class GuessRoundViewController: UIViewController {
    
    var phraseBank:PhraseBank!
    
    @IBOutlet weak var phraseTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Put up the phrase on screen
        let phrase = phraseBank.getNextPhrase()
        phraseTextView.text = phrase
        phraseTextView.font = UIFont(name: phraseTextView.font.fontName, size: 20)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
