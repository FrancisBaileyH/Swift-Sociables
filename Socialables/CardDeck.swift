//
//  CardDeck.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-03-08.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import Foundation


struct Card {
    var rank : String
    var suit : String
}


enum DeckBias {
    case girlsDrinkMore
    case guysDrinkMore
    case noBias
}


class CardDeck
{
    private let size : UInt32 = 52
    
    
    var bias: DeckBias
    var deckPtr : Int
    var deck = [Card]()
    var endOfDeck : Bool
    let suits : [String] = [ "hearts", "spades", "diamonds", "clubs" ]
    let ranks : [String] = [ "ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
    
    
    
    
    static let sharedInstance = CardDeck()
    
    
    
    init()
    {
        // build deck
        bias = DeckBias.noBias
        
        self.deckPtr = 0
        
        for ( var i = 0; i < Int(self.size); i++ )
        {
            self.deck.append(Card(rank: self.ranks[i % 13], suit: self.suits[i / 13])) // append card object with  rule title - rule name - card name
        }
        
        
        // shuffle deck after initialization
        self.endOfDeck = false
        self.shuffle()
    }
    
    
    
    private func determineBias(bias: DeckBias) {
    
        // size / 13
        
        
        /*
        switch bias {
        case .girlsDrinkMore:
            break
        default:
            
        }*/
    }
    
    
    /*
     * First build a normal deck of cards
     * any number greater than 52, we will now just grab a random card
     * from the available set of cards
    */
    private func buildDeck(deckSize: Int, bias: DeckBias) {
        
        for ( var i = 0; i < Int(self.size); i++ )
        {
            var idx = i
            
            if i > Int(self.size) {
                idx = generateRandomDeckIndex()
            }
            
            self.deck.append(Card(rank: self.ranks[idx % 13], suit: self.suits[idx / 13])) // append card object with  rule title - rule name - card name
        }
    }
    
    
    func generateRandomDeckIndex() -> Int {
        return Int(arc4random_uniform(self.size))
    }
    
    
    func shuffle()
    {
        for ( var i = 0; i < Int(self.size); i++ )
        {
            let idx = generateRandomDeckIndex()
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
    
    
    func returnToTop() -> Card?
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
