//
//  RulesPageViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/26/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class RulesPageViewController: UIViewController {
    
    var titleLabel: UILabel!
    var summaryText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTitle()
        createRulesSummary()
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[titleLabel]-[summaryText]", options: nil, metrics: nil, views: ["titleLabel": titleLabel, "topLayoutGuide": topLayoutGuide, "summaryText": summaryText])
        view.addConstraints(verticalSpacingConst)
    }
    
    func createTitle() {
        //Create the title label
        titleLabel = UILabel(frame: CGRect())
        titleLabel.text = "Rules Summary"
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 30.0)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        //Horizontally center title
        let horizontalCenterConst = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
    }
    
    func createRulesSummary() {
        //Create the rules summary text view by readining in the rules.txt file
        let filePath = NSBundle.mainBundle().pathForResource("rules", ofType: ".txt")
        let rulesSummaryText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        summaryText = UITextView(frame: CGRect())
        summaryText.text = rulesSummaryText
        summaryText.setTranslatesAutoresizingMaskIntoConstraints(false)
        summaryText.backgroundColor = .cyanColor()
        view.addSubview(summaryText)
        //Set the width proportional to screen width
        let widthConst = NSLayoutConstraint(item: summaryText, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0.0)
        view.addConstraint(widthConst)
        //Set height
        let heightConst = NSLayoutConstraint(item: summaryText, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        view.addConstraint(heightConst)
        //Horizontally center the text
        let horizontalCenterConst = NSLayoutConstraint(item: summaryText, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(horizontalCenterConst)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
