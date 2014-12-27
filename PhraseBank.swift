//
//  PhraseBank.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/27/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import Foundation

class PhraseBank {
    
    //This array will store all of our potential phrases
    var phraseArray = ["The Cat in the Hat", "Beauty and the Beast", "Hello World"]
    
    //Randomly grab a new phrase from the phrase array and return it
    func getNextPhrase() -> String {
        let randomNumber = Int(arc4random_uniform(UInt32(phraseArray.count)))
        let nextPhrase = phraseArray[randomNumber]
        phraseArray.removeAtIndex(randomNumber)
        return nextPhrase
    }
}
