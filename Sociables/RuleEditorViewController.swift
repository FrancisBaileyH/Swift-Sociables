//
//  RuleEditorViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//

import UIKit


class RuleEditorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
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
        
        ruleTextField.delegate = self
        ruleTitleField.delegate = self
        ruleTextField.layer.borderWidth = 0
        ruleTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        ruleTextField.layer.cornerRadius = 5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
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
            
            let order = RuleManager.defaultRules[cardTypeLabel.text!]?.order
            let rule = CardAndRuleType(rule: RuleType(title: ruleTitleField.text, explanation: ruleTextField.text, order: order!), rank: cardTypeLabel.text!, isDefault: false)
        
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
    
    
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
