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
    var cardType: String? = nil
    
    
    let rm = RuleManager.sharedInstance
    
    
    
    override func viewDidLoad() {
        ruleTextField.text = ruleText
        ruleTitleField.text = ruleTitle
        cardTypeLabel.text = cardType
        
        ruleTextField.layer.borderWidth = 1
    }
    
    
    @IBAction func saveButtonPressed() {
        // handle validation
    }
    
    @IBAction func resetButtonPressed() {
        //reset this value yo!
    }
    
    
}
