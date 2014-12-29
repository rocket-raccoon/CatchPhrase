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
    var prevWinner = 1
    var currentRound = 1
    var totalRounds = 10
    var maxSkips = 3
    var curSkips = 0
    
    func incrementTeam1Score() {
        self.team1Score += 1
        self.prevWinner = 1
    }
    
    func incrementTeam2Score() {
        self.team2Score += 1
        self.prevWinner = 2
    }
    
    func addRebuttal() {
        if(self.prevWinner == 1) {
            self.team1Score += 1
        } else {
            self.team2Score += 1
        }
    }
    
    func skipsLeft() -> Bool {
        if (curSkips < maxSkips) {
            return true
        }
        return false
    }
    
}
