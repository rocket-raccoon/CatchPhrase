//
//  CategorySelectViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/31/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CategorySelectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selectButton: UIButton!
    var headerLabel: UILabel!
    var categoryPicker: UIPickerView!
    var categories = [["Easy", "Medium", "Hard", "Animals", "Food", "Household Items", "People", "Travel"]]
    var selectedCategory:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderLabel()
        setupCategoryPicker()
        setupSelectButton()
        selectedCategory = categories[0][0]
    }
    
    func setupHeaderLabel() {
        //Create the header label
        let headerLabelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.text = "Please Select a Category"
        headerLabel.font = UIFont(descriptor: headerLabel.font.fontDescriptor(), size: 30)
        headerLabel.sizeToFit()
        headerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(headerLabel)
        //Set the constraints for the header label
        let viewDictionary = ["view": view, "headerLabel": headerLabel, "topLayoutGuide": topLayoutGuide]
        let horizontalCenterConst = NSLayoutConstraint(item: headerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        let verticalSpacingConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[headerLabel]", options: nil, metrics: nil, views: viewDictionary)
        view.addConstraint(horizontalCenterConst)
        view.addConstraints(verticalSpacingConst)
    }
    
    func setupSelectButton() {
        //Create the select category button
        selectButton = StandardButtonCreator().createStandardButton("Select", enclosingView: view)
        selectButton.addTarget(self, action: Selector("startGame"), forControlEvents: .TouchUpInside)
        //Center the button horizontally
        let centerHorizontalConst = NSLayoutConstraint(item: selectButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        view.addConstraint(centerHorizontalConst)
        //Place the button just above bottom of screen
        let verticalSpaceConst = NSLayoutConstraint.constraintsWithVisualFormat("V:[selectButton]-30-|", options: nil, metrics: nil, views: ["selectButton": selectButton])
        view.addConstraints(verticalSpaceConst)
    }
    
    func setupCategoryPicker() {
        //Create the picker view
        let pickerViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        categoryPicker = UIPickerView(frame: pickerViewFrame)
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(categoryPicker)
        //Position it just below the header label
        let justBelowLabelConst = NSLayoutConstraint(item: categoryPicker, attribute: .Top, relatedBy: .Equal, toItem: headerLabel, attribute: .Bottom, multiplier: 0.0, constant: 100)
        view.addConstraint(justBelowLabelConst)
    }
    
    func startGame() {
        var roundVC = GuessRoundViewController()
        var phraseBank = PhraseBank(category: selectedCategory)
        var scoreKeeper = ScoreKeeper()
        roundVC.phraseBank = phraseBank
        roundVC.scoreKeeper = scoreKeeper
        navigationController?.pushViewController(roundVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[0][pickerView.selectedRowInComponent(0)]
    }
    
}






