//
//  CurrentStandingsViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CurrentStandingsViewController: InGameViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var standingsCellWidth = [Int: CGFloat]()         //Holds the cell width for each section of the collection view
    var standingsCellHeight = CGFloat(0.0)           //Holds the cell height for every cell of the collection view
    var standingsGrid: UICollectionView!
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    var labels = [["Team 1 Score", "AAAAAAAAAAA"], ["Team 2 Score", "0"], ["Current Round", "CCCCCCCCCCCC"]]
    
    var headerLabel: UILabel!
    var continueButton: UIButton!
    var endGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update scores
        labels[0][1] = String(scoreKeeper.team1Score)
        labels[1][1] = String(scoreKeeper.team2Score)
        labels[2][1] = String(scoreKeeper.currentRound)
        //Setup the views on the screen
        precalculateCellSizes()
        setupStandingsGrid()
        setupHeaderLabel()
        verticallyOrientHeaderAndGrid()
        setupButtons()
    }
    
    func setupHeaderLabel() {
        //Create the headerlabel
        headerLabel = UILabel(frame: CGRect())
        headerLabel.text = "Current Standings"
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 30.0)
        headerLabel.sizeToFit()
        view.addSubview(headerLabel)
        //Horizontally center the header label
        let horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
    }
    
    func verticallyOrientHeaderAndGrid() {
        let viewDictionary = ["headerLabel": headerLabel, "standingsGrid": standingsGrid, "topLayoutGuide": topLayoutGuide]
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-[headerLabel]-[standingsGrid]", options: nil, metrics: nil, views: viewDictionary)
        view.addConstraints(verticalSpacingConst)
    }
    
    func setupButtons() {
        //Create the continue and end game buttons
        continueButton = StandardButtonCreator().createStandardButton("Continue", enclosingView: view)
        endGameButton = StandardButtonCreator().createStandardButton("End Game", enclosingView: view)
        //Horizontally center both of these buttons
        var horizontalCenterConst = NSLayoutConstraint(item: continueButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        horizontalCenterConst = NSLayoutConstraint(item: endGameButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Vertically align the buttons from the bottom of the screen
        let viewDictionary = ["continueButton": continueButton, "endGameButton": endGameButton]
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[continueButton]-[endGameButton]-30-|", options: nil, metrics: nil, views: viewDictionary)
        view.addConstraints(verticalSpacingConst)
        //Set the action targets for both buttons
        continueButton.addTarget(self, action: Selector("continueGame"), forControlEvents: .TouchUpInside)
        endGameButton.addTarget(self, action: Selector("endGame"), forControlEvents: .TouchUpInside)
    }
    
    func setupStandingsGrid() {
        //Create the standings grid or table
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        standingsGrid = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: layout)
        standingsGrid.registerClass(StandingsCell.self, forCellWithReuseIdentifier: "cell")
        standingsGrid.delegate = self
        standingsGrid.dataSource = self
        standingsGrid.setTranslatesAutoresizingMaskIntoConstraints(false)
        standingsGrid.sizeToFit()
        view.addSubview(standingsGrid)
        //Horizontally center it
        let horizontalCenterConst = NSLayoutConstraint(item: standingsGrid, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
        //Set the height and width constraints
        let heightConst = NSLayoutConstraint(item: standingsGrid, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 200)
        let widthConst = NSLayoutConstraint(item: standingsGrid, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 200)
        view.addConstraint(heightConst)
        view.addConstraint(widthConst)
    }
    
    //Returns us to another round of CatchPhrase
    func continueGame() {
        scoreKeeper.currentRound += 1
        let guessRoundVC = navigationController!.viewControllers[2] as GuessRoundViewController
        navigationController?.popToViewController(guessRoundVC, animated: false)
    }
    
    func endGame() {
        var endGameVC = EndGameViewController()
        endGameVC.scoreKeeper = scoreKeeper
        navigationController?.pushViewController(endGameVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //We want to iterate over each cell in the collection view to determine what
    //the tallest cell is overall as well as the widest cell per column
    func precalculateCellSizes() {
        let numRows = labels.count
        let numCols = labels[0].count
        for i in 0...(numRows-1) {
            for j in 0...(numCols-1) {
                var textLabel = UILabel(frame: CGRect())
                textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                textLabel.text = labels[i][j]
                textLabel.sizeToFit()
                let cellWidth = textLabel.frame.width
                let cellHeight = textLabel.frame.height
                if cellHeight > standingsCellHeight {
                    standingsCellHeight = cellHeight
                }
                if let curStandingsCellWidth = standingsCellWidth[j] {
                    if cellWidth > curStandingsCellWidth {
                        standingsCellWidth[j] = cellWidth
                    }
                } else {
                    standingsCellWidth[j] = cellWidth
                }
            }
        }
    }
    
    func getSizeForStandingsCell(indexPath: NSIndexPath) -> CGSize {
        let section = indexPath.section
        let row = indexPath.row
        var textLabel = UILabel(frame: CGRect())
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.text = labels[section][row]
        textLabel.sizeToFit()
        return textLabel.frame.size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = standingsCellWidth[indexPath.row]
        let h = standingsCellHeight
        return CGSizeMake(w!, h)
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
        cell.textLabel.sizeToFit()
        return cell
    }
    
}




