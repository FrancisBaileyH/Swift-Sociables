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


class RuleManager
{
    let defaultRule : [String: String] = [
        "ace"   : "Drink in a circle",
        "2"     : "Choose someone to drink",
        "3"     : "You drink",
        "4"     : "Girls drink",
        "5"     : "Go around in a circle saying something you've never done. When someone has done a total of 3 things mentioned, they drink",
        "6"     : "Guys drink",
        "7"     : "Pick a category such as sports teams or beer brands and go around in a circle with the next person saying something in the category. The first player who can't think of anything drinks.",
        "8"     : "Choose another player to drink everytime you drink.",
        "9"     : "Pick a word to rhyme. Players then go in a circle trying to rhyme with that word. The first person who can't think of rhyme drinks.",
        "10"    : "...",
        "jack"  : "...",
        "queen" : "You can now ask anyone a question, if they answer they drink. You stop being question master when the next Queen is drawn.",
        "king"  : "..."
    ]
    
    let defaultRuleName : [String: String] = [
        "ace"   : "Waterfall",
        "2"     : "Two is you",
        "3"     : "Three is me",
        "4"     : "Whores",
        "5"     : "Never have I ever",
        "6"     : "Dicks",
        "7"     : "Categories",
        "8"     : "Date",
        "9"     : "Rhyme",
        "10"    : "...",
        "jack"  : "...",
        "queen" : "Question Master",
        "king"  : "..."
    ]
    
    
    
    func getRule( rank : String ) -> Rule {
        return Rule( name: self.defaultRuleName[rank]!, explanation: self.defaultRule[rank]! )
    }
    
    
    
    
}
