//
//  CurrentStandingsViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/28/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CurrentStandingsViewController: InGameViewController, UITableViewDataSource, UITableViewDelegate {
    
    var standingsCellWidth = [Int: CGFloat]()         //Holds the cell width for each section of the collection view
    var standingsCellHeight = CGFloat(0.0)           //Holds the cell height for every cell of the collection view
    var standingsGrid: UICollectionView!
    var scoreKeeper:ScoreKeeper!
    var phraseBank:PhraseBank!
    var labels = [["Team 1 Score", "AAAAAAAAAAA"], ["Team 2 Score", "0"], ["Current Round", "CCCCCCCCCCCC"]]
    
    var headerLabel: UILabel!
    var continueButton: UIButton!
    var endGameButton: UIButton!
    var standingsTableView: UITableView!
    
    var standingsTableViewHeightConst: NSLayoutConstraint!
    
    private struct Constants {
        static let CellReuseID = "Cell Reuse Identifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update scores
        labels[0][1] = String(scoreKeeper.team1Score)
        labels[1][1] = String(scoreKeeper.team2Score)
        labels[2][1] = String(scoreKeeper.currentRound)
        //Setup the views on the screen
        setupHeaderLabel()
        setupStandingsGrid()
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
        
        //Instantiate an instance of the table view to hold our standings
        standingsTableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        standingsTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        standingsTableView.registerClass(StandingsTableViewCell.self, forCellReuseIdentifier: Constants.CellReuseID)
        standingsTableView.estimatedRowHeight = standingsTableView.rowHeight
        standingsTableView.rowHeight = UITableViewAutomaticDimension
        standingsTableView.contentInset = UIEdgeInsetsZero
        standingsTableView.scrollEnabled = false
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        view.addSubview(standingsTableView)
        
        //Set the vertical constraints in autolayout
        let viewsDictionary = ["standingsTableView": standingsTableView, "tlg": topLayoutGuide, "headerLabel": headerLabel]
        let verticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[tlg]-[headerLabel]-[standingsTableView]", options: nil, metrics: nil, views: viewsDictionary)
        view.addConstraints(verticalConst)
        
        //Set the horizontal constants in autolayout
        let horizontalConst = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[standingsTableView]-|", options: nil, metrics: nil, views: viewsDictionary)
        view.addConstraints(horizontalConst)
        
        //Set height constraint
        standingsTableViewHeightConst = NSLayoutConstraint(item: standingsTableView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 500)
        view.addConstraint(standingsTableViewHeightConst)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseID) as StandingsTableViewCell
        cell.rowInformation = labels[indexPath.row]
        standingsTableViewHeightConst.constant = standingsTableView.contentSize.height
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
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
    
}

class StandingsTableViewCell: UITableViewCell {
    
    var categoryLabel: UILabel!
    var scoreLabel: UILabel!
    var rowInformation: [String]! {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCell()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell() {
        
        //Create the category label that goes on the left
        categoryLabel = UILabel()
        categoryLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(categoryLabel)
        
        //Create the score label that goes on the right
        scoreLabel = UILabel()
        scoreLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(scoreLabel)
        
        //Set the labels horizontal constraints
        let viewsDictionary = ["scoreLabel": scoreLabel, "categoryLabel": categoryLabel]
        let horizontalConst = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[categoryLabel]-[scoreLabel]-|", options: nil, metrics: nil, views: viewsDictionary)
        contentView.addConstraints(horizontalConst)
        
        //Set the labels vertical constraints
        let categoryVerticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[categoryLabel]-|", options: nil, metrics: nil, views: viewsDictionary)
        contentView.addConstraints(categoryVerticalConst)
        let scoreVerticalConst = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[scoreLabel]-|", options: nil, metrics: nil, views: viewsDictionary)
        contentView.addConstraints(scoreVerticalConst)
    }
    
    func updateUI() {
        if rowInformation != nil {
            categoryLabel?.text = rowInformation[0]
            scoreLabel?.text = rowInformation[1]
        }
    }
}










