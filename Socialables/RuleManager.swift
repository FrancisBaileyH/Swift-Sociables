//
//  RuleTypeManager.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-03-20.
//

import CoreData
import UIKit


struct RuleType {
    var title : String
    var explanation : String
    var order: Int
}

struct CardAndRuleType {
    var rule: RuleType
    var rank: String
    var isDefault: Bool
}



class RuleManager
{
    
    static let sharedInstance = RuleManager()
    
    
    let coreData: NSManagedObjectContext
    let ruleEntityDescription: NSEntityDescription
    
    
    let defaultGirlsDrinkCard = DeckBias.girlsDrinkMore.rawValue
    let defaultGuysDrinkCard = DeckBias.guysDrinkMore.rawValue
    
    
    init() {
        coreData = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        ruleEntityDescription = NSEntityDescription.entityForName("Rule", inManagedObjectContext: coreData)!
    }
    
    
    
    static let defaultRules : [String: RuleType] = [
        "Ace"   : RuleType(title: "Waterfall", explanation: "Drink in a circle starting with the person who drew this card. When that person stops drinking the next person may also stop and so on, until the end of the cirlce is reached.", order: 1),
        "2"     : RuleType(title: "Two is you", explanation: "Choose someone to drink", order: 2),
        "3"     : RuleType(title: "Three is me", explanation: "You drink", order: 3),
        "4"     : RuleType(title: "Whores", explanation: "Girls drink", order: 4),
        "5"     : RuleType(title: "Never have I ever", explanation: "Go around in a circle and say something you've never done. When someone has done a total of 3 things mentioned, they drink", order: 5),
        "6"     : RuleType(title: "Dicks", explanation: "Guys drink", order: 6),
        "7"     : RuleType(title: "Categories", explanation: "Pick a category such as sports teams or beer brands and go around in a circle with the next person saying something in the category. The first player who can't think of anything drinks.", order: 7),
        "8"     : RuleType(title: "Date", explanation: "Choose another player to drink everytime you drink.", order: 8),
        "9"     : RuleType(title: "Rhyme Time", explanation: "Pick a word to rhyme. Everyone goes in a circle trying to rhyme with that word. The first person who can't think of rhyme drinks.", order: 9),
        "10"    : RuleType(title: "Rule Card", explanation: "Pick a rule that must be followed for the rest of the game. If a person breaks the rule, they drink.", order: 10),
        "Jack"  : RuleType(title: "Eyes", explanation: "Everyone puts their head down and on the count of 3 looks up at a random person. If two people meet eyes, they drink. Repeat 3 times.", order: 11),
        "Queen" : RuleType(title: "Question Master", explanation: "You can now ask anyone questions, if they answer they drink. You stop being question master when the next Queen is drawn.", order: 12),
        "King"  : RuleType(title: "Sociables", explanation: "Everyone drinks!", order: 13)
    ]
    
    
    
    /*
     * Save a rule into persistent storage, if the rule already exists, then simply
     * update the rule return an error if one is found
    */
    func saveRule( rule: CardAndRuleType )  -> NSError? {
        
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
       
        let request       = NSFetchRequest()
        request.entity    = ruleEntityDescription
        request.predicate = NSPredicate(format: "(" + Rule.ruleRankKey + " = %@)", rank)
        
        var results = coreData.executeFetchRequest(request, error: nil)

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
    func getRule( rank : String ) -> CardAndRuleType {
        
        if let rule = fetchRuleFromStorage(rank) {
            
            let title       = rule.valueForKey(Rule.ruleTitleKey) as! String
            let explanation = rule.valueForKey(Rule.ruleExplanationKey) as! String
            let order = RuleManager.defaultRules[rank]?.order
            
            return CardAndRuleType(rule: RuleType(title: title, explanation: explanation, order: order! ), rank: rank, isDefault: false)
        }
        else {
            return CardAndRuleType(rule: RuleManager.defaultRules[rank]!, rank: rank, isDefault: true)
        }
    }
    
    
    /*
     * Fetch all RuleTypes, but return as an array of CardAndRuleType types
     * to allow indexing of array. This most likely will change
     * in the future
    */
    func getAllRules() -> [CardAndRuleType] {
        
        var rules = [CardAndRuleType]()
        var rulesTmp = [String: RuleType]()
        
        let request = NSFetchRequest(entityName: "Rule")
        let persistentRules = coreData.executeFetchRequest(request, error: nil) as? [Rule]
        
        if persistentRules?.count > 0 {
            
            for rule in persistentRules! {
                let order = RuleManager.defaultRules[rule.rank.capitalizedString]?.order
                
                println(rule.rank)
                
                rulesTmp.updateValue(RuleType(title: rule.title, explanation: rule.explanation, order: order!), forKey: rule.rank)
            }
        }
        
        for rule in RuleManager.defaultRules {
            
            if rulesTmp[rule.0] == nil {
                let order = RuleManager.defaultRules[rule.0]?.order
                rules.append(CardAndRuleType(rule: RuleType(title: rule.1.title, explanation: rule.1.explanation, order: order!), rank: rule.0, isDefault: true))
            } else {
                rules.append(CardAndRuleType(rule: rulesTmp[rule.0]!, rank: rule.0, isDefault: false))
            }
        }
        
        return sortRules(rules)
    }
    
    
    /*
     * Sort rules by order established in the RuleType struct
    */
    func sortRules(rules: [CardAndRuleType]) -> [CardAndRuleType] {
        
        var sortedRules = rules
        
        sortedRules.sort({ $0.rule.order < $1.rule.order })
   
        return sortedRules
    }
    
    
    
    
}
