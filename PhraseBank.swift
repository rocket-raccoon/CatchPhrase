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
    var phraseArray:[String]!
    var copyPhraseArray:[String]!
    
    init(category: String) {
        //Read in the appropriate set of phrases based on the category passed in
        let filePath = NSBundle.mainBundle().pathForResource(category, ofType: ".txt")
        var contents = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        var phrases = contents!.componentsSeparatedByString("\n")
        phraseArray = phrases
        copyPhraseArray = phraseArray
    }
    
    //Randomly grab a new phrase from the phrase array and return it
    func getNextPhrase() -> String {
        if (phraseArray.count == 0) {
            phraseArray = copyPhraseArray
        }
        let randomNumber = Int(arc4random_uniform(UInt32(phraseArray.count)))
        let nextPhrase = phraseArray[randomNumber]
        phraseArray.removeAtIndex(randomNumber)
        return nextPhrase
    }
}
