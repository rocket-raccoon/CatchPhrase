//
//  ScoreKeeper.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/27/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import Foundation

class ScoreKeeper {
    
    var team1Score = 0
    var team2Score = 0
    
    func incrementTeam1Score() {
        self.team1Score += 1
    }
    
    func incrementTeam2Score() {
        self.team2Score += 1
    }
    
}
