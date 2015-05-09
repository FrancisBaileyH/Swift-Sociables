//
//  RuleEditorViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit


class RuleEditorViewController: UIViewController, UITextFieldDelegate {
    
    
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
        
        let card = rm.getRule(cardRank!)
        
        if card.rule.explanation == ruleTextField.text && card.rule.title == ruleTitleField.text {
            let message = UIAlertController(title: "Rule Unchanged", message: "Please change the values of the rule title or rule text in order to save.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            message.addAction(OKAction)
            self.presentViewController(message, animated: true, completion: nil)
        }
        else {
            let rule = CardAndRule(rule: RuleType(title: ruleTitleField.text, explanation: ruleTextField.text), rank: cardTypeLabel.text!, isDefault: false)
        
            if let err = rm.saveRule(rule) {
                let warning = UIAlertController(title: "Error", message: "An error occurred and the rule was not successfully saved. Please try again.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                warning.addAction(OKAction)
                self.presentViewController(warning, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    
    @IBAction func resetButtonPressed() {
        
        rm.removePersistentRule(cardTypeLabel.text!)
        
        let card = rm.getRule(cardRank!)

        ruleTitleField.text = card.rule.title
        ruleTextField.text = card.rule.explanation
        

        let message = UIAlertController(title: "Rule Reset", message: "Rule reset to default value.", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        message.addAction(OKAction)
        self.presentViewController(message, animated: true, completion: nil)
    }
    
    
}
