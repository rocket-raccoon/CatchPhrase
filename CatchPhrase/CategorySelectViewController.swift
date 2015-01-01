//
//  CategorySelectViewController.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 12/31/14.
//  Copyright (c) 2014 rocket-raccoon. All rights reserved.
//

import UIKit

class CategorySelectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var categories = [["Easy", "Medium", "Hard", "Animals", "Food", "Household Items", "People", "Travel"]]
    var selectedCategory:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        selectedCategory = categories[0][0]
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "continueToGame") {
            var roundVC = segue.destinationViewController as GuessRoundViewController
            var phraseBank = PhraseBank(category: selectedCategory)
            var scoreKeeper = ScoreKeeper()
            roundVC.phraseBank = phraseBank
            roundVC.scoreKeeper = scoreKeeper
        }
    }
    
}






