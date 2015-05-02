//
//  RuleManager.swift
//  Socialables
//
//  Created by CIS-Mac-16 on 2015-03-20.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import CoreData

struct Rule {
    var name : String
    var explanation : String
}

struct CardAndRule {
    var rule: Rule
    var cardType: String
}


class RuleManager
{
    
    static let sharedInstance = RuleManager()
    
    
    
    let defaultRules : [String: Rule] = [
        "ace"   : Rule(name: "Waterfall", explanation: "Drink in a circle"),
        "2"     : Rule(name: "Two is you", explanation: "Choose someone to drink"),
        "3"     : Rule(name: "Three is me", explanation: "You drink"),
        "4"     : Rule(name: "Whores", explanation: "Girls drink"),
        "5"     : Rule(name: "Never have I ever", explanation: "Go around in a circle saying something you've never done. When someone has done a total of 3 things mentioned, they drink"),
        "6"     : Rule(name: "Dicks", explanation: "Guys drink"),
        "7"     : Rule(name: "Categories", explanation: "Pick a category such as sports teams or beer brands and go around in a circle with the next person saying something in the category. The first player who can't think of anything drinks."),
        "8"     : Rule(name: "Date", explanation: "Choose another player to drink everytime you drink."),
        "9"     : Rule(name: "Rhyme", explanation: "Pick a word to rhyme. Players then go in a circle trying to rhyme with that word. The first person who can't think of rhyme drinks."),
        "10"    : Rule(name: "...", explanation: "..."),
        "jack"  : Rule(name: "...", explanation: "..."),
        "queen" : Rule(name: "Question Master", explanation: "You can now ask anyone a question, if they answer they drink. You stop being question master when the next Queen is drawn."),
        "king"  : Rule(name: "...", explanation: "...")
    ]
    
    
    
    
    func getRule( rank : String ) -> Rule {
        return defaultRules[rank]!
    }
    
    
    func getAllRules() -> [CardAndRule] {
        
        var rules = [CardAndRule]()
        
        for rule in defaultRules {
            rules.append(CardAndRule(rule: Rule(name: rule.1.name, explanation: rule.1.explanation), cardType: rule.0))
        }
        
        return rules
    }
    
    
    
    
}
