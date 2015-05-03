//
//  RuleEditorViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit


class RuleEditorViewController: UIViewController {
    
    
    @IBOutlet weak var ruleTextField: UITextView!
    @IBOutlet weak var ruleTitleField: UITextField!
    @IBOutlet weak var cardTypeLabel: UILabel!
    
   
    var ruleText: String? = nil
    var ruleTitle: String? = nil
    var cardRank: String? = nil
    
    
    let rm = RuleManager.sharedInstance
    
    
    override func viewDidLoad() {
        ruleTextField.text = ruleText
        ruleTitleField.text = ruleTitle
        cardTypeLabel.text = cardRank
        
        ruleTextField.layer.borderWidth = 1
    }
    
    
    @IBAction func saveButtonPressed() {
        let rule = CardAndRule(rule: RuleType(title: ruleTitleField.text, explanation: ruleTextField.text), rank: cardTypeLabel.text!)
        
        if let err = rm.saveRule(rule) {
            // set error
        } else {
           self.navigationController?.popViewControllerAnimated(true)
        }
        
        
    }
    
    @IBAction func resetButtonPressed() {
        
        if let err = rm.removePersistentRule(cardTypeLabel.text!) {
            // set error label
            println(err.localizedDescription)
        }
    }
    
    
}
