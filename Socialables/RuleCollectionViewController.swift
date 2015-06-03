//
//  RuleCollectionViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit


class RuleCollectionViewController: UIViewController, CellActionDelegate {
    
    
    @IBOutlet weak var ruleCollection: UICollectionView!
    
    let rm = RuleManager.sharedInstance
    var rules = [CardAndRuleType]()
    
    
    /*
     * Fetch all rules on load
    */
    override func viewDidLoad() {

    }
    
    
    override func viewDidAppear(animated: Bool) {
        rules = rm.getAllRules()
        ruleCollection.reloadData()
    }
    
    

    /*
     * Handle button press actions from within the 
     * RuleCollectionViewCell
    */
    func buttonPressed(cell: RuleCollectionViewCell, action: String) {
        
        if action == "edit" {

            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
            let ruleEditor = mainStoryboard.instantiateViewControllerWithIdentifier("RuleEditorViewController") as! RuleEditorViewController
        
        
            ruleEditor.ruleTitle = cell.ruleTitle.text
            ruleEditor.ruleText = cell.ruleText.text
            ruleEditor.cardRank = cell.cardType.text

            self.navigationController?.pushViewController(ruleEditor, animated: true)
        }
    }
    
    
}





extension RuleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = ruleCollection.dequeueReusableCellWithReuseIdentifier("RuleViewCell", forIndexPath: indexPath) as! RuleCollectionViewCell
        
        let rule = rules[indexPath.row]
        
        cell.cardType.text = rule.rank
        cell.ruleTitle.text = rule.rule.title
        cell.ruleText.text = rule.rule.explanation
        
        
        
        cell.delegate = self

        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rules.count
    }
    
}
