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
    var rules = [CardAndRule]()
    
    
    override func viewDidLoad() {
        rules = rm.getAllRules()
    }
    

    func buttonPressed(cell: RuleCollectionViewCell, action: String) {
        println(cell.ruleText.text)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        let ruleEditor = mainStoryboard.instantiateViewControllerWithIdentifier("RuleEditorViewController") as! RuleEditorViewController
        
        println(ruleEditor)
        ruleEditor.ruleTitle = cell.ruleTitle.text
        ruleEditor.ruleText = cell.ruleText.text
        ruleEditor.cardType = cell.cardType.text

        self.navigationController?.pushViewController(ruleEditor, animated: true)
    }
    
    
}





extension RuleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = ruleCollection.dequeueReusableCellWithReuseIdentifier("RuleViewCell", forIndexPath: indexPath) as! RuleCollectionViewCell
        
        let rule = rules[indexPath.row]
        
        cell.cardType.text = rule.cardType
        cell.ruleTitle.text = rule.rule.name
        cell.ruleText.text = rule.rule.explanation
        
        cell.delegate = self
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rules.count
    }
    
}
