//
//  RuleTypeManager.swift
//  Socialables
//
//  Created by CIS-Mac-16 on 2015-03-20.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import CoreData
import UIKit


struct RuleType {
    var title : String
    var explanation : String
}

struct CardAndRule {
    var rule: RuleType
    var rank: String
}


class RuleManager
{
    
    static let sharedInstance = RuleManager()
    
    
    let coreData: NSManagedObjectContext
    let ruleEntityDescription: NSEntityDescription
    
    
    init() {
        coreData = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        ruleEntityDescription = NSEntityDescription.entityForName("Rule", inManagedObjectContext: coreData)!
    }
    
    
    
    let defaultRules : [String: RuleType] = [
        "ace"   : RuleType(title: "Waterfall", explanation: "Drink in a circle"),
        "2"     : RuleType(title: "Two is you", explanation: "Choose someone to drink"),
        "3"     : RuleType(title: "Three is me", explanation: "You drink"),
        "4"     : RuleType(title: "Whores", explanation: "Girls drink"),
        "5"     : RuleType(title: "Never have I ever", explanation: "Go around in a circle saying something you've never done. When someone has done a total of 3 things mentioned, they drink"),
        "6"     : RuleType(title: "Dicks", explanation: "Guys drink"),
        "7"     : RuleType(title: "Categories", explanation: "Pick a category such as sports teams or beer brands and go around in a circle with the next person saying something in the category. The first player who can't think of anything drinks."),
        "8"     : RuleType(title: "Date", explanation: "Choose another player to drink everytime you drink."),
        "9"     : RuleType(title: "Rhyme", explanation: "Pick a word to rhyme. Players then go in a circle trying to rhyme with that word. The first person who can't think of rhyme drinks."),
        "10"    : RuleType(title: "...", explanation: "..."),
        "jack"  : RuleType(title: "...", explanation: "..."),
        "queen" : RuleType(title: "Question Master", explanation: "You can now ask anyone a question, if they answer they drink. You stop being question master when the next Queen is drawn."),
        "king"  : RuleType(title: "...", explanation: "...")
    ]
    
    
    
    /*
     * Save a rule into persistent storage, if the rule already exists, then simply
     * update the rule return an error if one is found
    */
    func saveRule( rule: CardAndRule )  -> NSError? {
        
        var error: NSError?
        
        if let savedRule = fetchRuleFromStorage(rule.rank) {
            savedRule.setValue(rule.rank, forKey: Rule.ruleRankKey)
            savedRule.setValue(rule.rule.title, forKey: Rule.ruleTitleKey)
            savedRule.setValue(rule.rule.explanation, forKey: Rule.ruleExplanationKey)
            
        } else {
        
            let ruleEntity = Rule(entity: ruleEntityDescription, insertIntoManagedObjectContext: coreData)
        
            ruleEntity.rank        = rule.rank
            ruleEntity.title       = rule.rule.title
            ruleEntity.explanation = rule.rule.explanation
        }
        
        coreData.save(&error)
        println(error)
        return error
    }
    
    
    /*
     * Remove a rule in persistent storage
    */
    func removePersistentRule( rank: String ) -> NSError? {
        
        if let rule = fetchRuleFromStorage(rank) {
            coreData.deleteObject(rule)
            coreData.save(nil)
            
            return nil
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Current rule is already default rule"])
           
            return error
        }
        
        
    }
    
    
    /*
     * Remove all rules in persistent storage
    */
    func removeAllPersistentRules() {
        
    }
    
    
    
    /*
     * Attempt to fetch the Rule from persistent storage
     * if no rule is found nil will be returned
    */
    internal func fetchRuleFromStorage( rank: String ) -> NSManagedObject? {
       
        let request = NSFetchRequest()
        request.entity    = ruleEntityDescription
        request.predicate = NSPredicate(format: "(" + Rule.ruleRankKey + " = %@)", rank)
        
        var results = coreData.executeFetchRequest(request, error: nil)
        println(results?.count)
        if results?.count > 0 {
            return results?[0] as? NSManagedObject
        } else {
            return nil
        }
        
    }
    
    
    
    /*
     * Fetch individual RuleType by rank, if no rule is found in
     * persistent storage, then return the default rule
    */
    func getRule( rank : String ) -> CardAndRule {
        
        if let rule = fetchRuleFromStorage(rank) {
            
            let title       = rule.valueForKey(Rule.ruleTitleKey) as! String
            let explanation = rule.valueForKey(Rule.ruleExplanationKey) as! String
            
            return CardAndRule(rule: RuleType(title: title, explanation: explanation), rank: rank)
        } else {
            return CardAndRule(rule: defaultRules[rank]!, rank: rank)
        }
    }
    
    
    /*
     * Fetch all RuleTypes, but return as an array of CardAndRuleType types
     * to allow indexing of array. This most likely will change
     * in the future
    */
    func getAllRules() -> [CardAndRule] {
        
        var rules = [CardAndRule]()
        var rulesTmp = [String: RuleType]()
        
        let request = NSFetchRequest(entityName: "Rule")
        let persistentRules = coreData.executeFetchRequest(request, error: nil) as? [Rule]
        
        if persistentRules?.count > 0 {
            for rule in persistentRules! {
                rulesTmp.updateValue(RuleType(title: rule.title, explanation: rule.explanation), forKey: rule.rank)
            }
        }
        
        for rule in defaultRules {
            
            if rulesTmp[rule.0] == nil {
                rules.append(CardAndRule(rule: RuleType(title: rule.1.title, explanation: rule.1.explanation), rank: rule.0))
            } else {
                rules.append(CardAndRule(rule: rulesTmp[rule.0]!, rank: rule.0))
            }
        }
        
        return rules
    }
    
    
    
    
}
