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


enum DeckBias: String {
    case girlsDrinkMore = "4"
    case guysDrinkMore = "6"
    case noBias = ""
}


class CardDeck
{
    private let size = 52
    private var customDeckSize: Int
    private var bias: DeckBias
    
    private var deckPtr : Int
    var deck = [Card]()
    var endOfDeck : Bool
    
    let suits : [String] = [ "Hearts", "Spades", "Diamonds", "Clubs" ]
    let ranks : [String] = [ "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
    
    var test : Int {
        get {
            return self.test
        }
        set(value) {
            self.test = value
        }
    }
    
    
    static let sharedInstance = CardDeck()
    
    
    
    init()
    {
        // build deck
        bias = DeckBias.noBias
        
        self.customDeckSize = size
        
        self.deckPtr = 0
        
        
        // shuffle deck after initialization
        self.endOfDeck = false
    }
    
    
    /*
     * First build a normal deck of cards
     * any number greater than 52, we will now just grab a random card
     * from the available set of cards
    */
    func buildDeck() {
        
        self.deck.removeAll(keepCapacity: false)
        
        for ( var i = 0; i < Int(self.customDeckSize); i++ )
        {
            var idx = i
            
            if i >= Int(self.size) {
                idx = generateRandomDeckIndex(self.size)
            }
            self.deck.append(Card(rank: self.ranks[idx % 13], suit: self.suits[idx / 13])) // append card object with  rule title - rule name - card name
        }
        
        if bias != DeckBias.noBias {
            applyBias()
        }
        
        shuffle()
    }
    
    
    /*
     * Generate a random number between 0 and the size of the deck - 1
    */
    func generateRandomDeckIndex(deckSize: Int) -> Int {
        return Int(arc4random_uniform(UInt32(deckSize)))
    }
    
    
    
    private func applyBias() {
        
        let numCardsToReplace: Int = self.customDeckSize / 16
        
        var i = 0;
        
        while ( i < numCardsToReplace ) {
        
            let suitIdx = generateRandomDeckIndex(self.size)
            let deckIdx = generateRandomDeckIndex(self.customDeckSize)
            
            let cardToReplaceWith: Card
            
            if self.bias == DeckBias.girlsDrinkMore {
                cardToReplaceWith = Card(rank: DeckBias.girlsDrinkMore.rawValue, suit: self.suits[suitIdx / 13])
            } else {
                cardToReplaceWith = Card(rank: DeckBias.guysDrinkMore.rawValue, suit: self.suits[suitIdx / 13] )
            }
            
            if self.deck[deckIdx].rank != cardToReplaceWith.rank {
                self.deck[deckIdx] = cardToReplaceWith
                i++
            }
            
        }
    }
    
    
    func shuffle()
    {
        for (var i = 0; i < 52 / 7; i++) {
            self.deck.shuffle()
        }
        // reset deckPtr
        self.deckPtr = 0
    }
    
    
    /*
     * Return the next card from the deck if there is one
    */
    func oneOffTheTop() -> Card?
    {
        if self.deckPtr > Int(self.customDeckSize) - 1 {
            self.endOfDeck = true
            return nil
        }
            
        // the deckPtr may have been set to less than 0
        // so reset to 0 to allow drawing to continue
        else if self.deckPtr < 0 {
            self.deckPtr = 0;
        } else if deck.count < 1 {
            return nil
        }
        
        
        let card = self.deck[self.deckPtr++]
        
        return card
    }
    
    
    /*
     * Return the previous card from the deck, if there is one
    */
    func returnToTop() -> Card?
    {
        if self.deckPtr < 0 {
            return nil
        }
        else if self.deckPtr > Int(self.customDeckSize) - 1 {
            self.deckPtr = Int(self.customDeckSize) - 1
        }
        
        let card = self.deck[self.deckPtr--]
        
        return card
    }
    
    
    /*
     * Getters and Setters
    */
    
    func setDeckBias(value: DeckBias) {
        self.bias = value
    }
    
    func setDeckSize(value: Int) {
        self.customDeckSize = value
    }
    
    func getDeckBias() -> DeckBias {
        return self.bias
    }
    
    func getDeckPtr() -> Int {
        return self.deckPtr
    }
    
    func getDeckSize() -> Int {
        return self.customDeckSize
    }
    
    
}


extension Array {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

