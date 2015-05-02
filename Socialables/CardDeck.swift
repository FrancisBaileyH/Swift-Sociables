//
//  CardDeck.swift
//  Socialables
//
//  Created by CIS-Mac-16 on 2015-03-08.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import Foundation


struct Card {
    var rank : String
    var suit : String
}


class CardDeck
{
    let size : UInt32 = 52
    
    var deckPtr : Int
    var deck = [Card]()
    var endOfDeck : Bool
    let suits : [String] = [ "hearts", "spades", "diamonds", "clubs" ]
    let ranks : [String] = [ "ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
    
    
    
    init()
    {
        // build deck
        self.deckPtr = 0
        
        for ( var i = 0; i < Int(self.size); i++ )
        {
            self.deck.append(Card(rank: self.ranks[i % 13], suit: self.suits[i / 13])) // append card object with  rule title - rule name - card name
        }
        
        // shuffle deck after initialization
        self.endOfDeck = false
        self.shuffle()
    }
    
    
    func shuffle()
    {
        for ( var i = 0; i < Int(self.size); i++ )
        {
            var idx = Int(arc4random_uniform(self.size))
            var tmp = self.deck[i]
            self.deck[i] = self.deck[idx]
            self.deck[idx] = tmp
            
        }
        
        // reset deckPtr
        self.deckPtr = 0
    }
    
    
    func oneOffTheTop() -> Card?
    {
        if self.deckPtr > Int(self.size) - 1 {
            self.endOfDeck = true
            return nil
        }
            
        // the deckPtr may have been set to less than 0
        // so reset to 0 to allow drawing to continue
        else if self.deckPtr < 0 {
            self.deckPtr = 0;
        }
        
        
        let card = self.deck[self.deckPtr++]
        
        return card
    }
    
    
    func returnToTop() ->Card?
    {
        if self.deckPtr < 0 {
            return nil
        }
        else if self.deckPtr > Int(self.size) - 1 {
            self.deckPtr = Int(self.size) - 1
        }
        
        let card = self.deck[self.deckPtr--]
        
        return card
    }
    
}
