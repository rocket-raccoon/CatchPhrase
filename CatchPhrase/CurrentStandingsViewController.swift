//
//  CurrentStandingsViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CurrentStandingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    var labels = [["Team 1 Score", "0"], ["Team 2 Score", "0"], ["Current Round", "0"]]
    
    @IBOutlet var standingsGrid: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable the back button, add an exit game button
        self.navigationItem.setHidesBackButton(true, animated: false)
        var b = UIBarButtonItem(title: "Exit Game", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("exitGame"))
        self.navigationItem.rightBarButtonItem = b
        //Update scores
        labels[0][1] = String(scoreKeeper.team1Score)
        labels[1][1] = String(scoreKeeper.team2Score)
        labels[2][1] = String(scoreKeeper.currentRound)
        //Set collection view
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: 50, height: 50)
        standingsGrid.collectionViewLayout = layout
        standingsGrid.registerClass(StandingsCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func exitGame() {
        performSegueWithIdentifier("exitGame", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startNextRound(sender: UIButton) {
        scoreKeeper.currentRound += 1
        performSegueWithIdentifier("startNextRound", sender: nil)
    }
    
    @IBAction func endGame(sender: UIButton) {
        performSegueWithIdentifier("endGame", sender: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return labels.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let row = indexPath.row
        var cell = standingsGrid.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as StandingsCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel.text = labels[section][row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "startNextRound") {
            var roundVC = segue.destinationViewController as GuessRoundViewController
            roundVC.scoreKeeper = scoreKeeper
            roundVC.phraseBank = phraseBank
        } else if (segue.identifier == "endGame") {
            var endGameVC = segue.destinationViewController as EndGameViewController
            endGameVC.scoreKeeper = scoreKeeper
        }
    }
    
}




