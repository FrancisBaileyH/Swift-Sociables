//
//  CardDeck.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-03-08.
//

import Foundation


/**
 * @struct Card
 *
 * @abstract 
 *      represents a physical deck card
 *
 * @field rank 
 *      represents the Card's rank (Ace to King)
 * @field suit 
 *      represents a Card's suit (Hearts, Spades, Diamonds, Clubs)
*/
struct Card {
    var rank : String
    var suit : String
}


/**
 * @enum DeckBias
 *
 * @abstract 
 *      Represents a bias that may be applied to the deck of cards
 *
 * @constant girlsDrinkMore 
 *      In Sociables the girls drink card is card 4
 * @constant guysDrinkMore 
 *      In Sociables the guys drink card is card 6
 * @constant noBias 
 *      used to apply no bias to the deck
*/
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
    
    
    static let sharedInstance = CardDeck()
    
    
    
    init() {

        bias = DeckBias.noBias
        
        self.customDeckSize = size
        self.deckPtr = 0
        self.endOfDeck = false
    }
    
    
    /*
     * Build a normal deck and for any deck size greater than 52
     * generate a random card from the default deck and insert it
    */
    func buildDeck() {
        
        self.deck.removeAll(keepCapacity: false)
        
        for ( var i = 0; i < Int(self.customDeckSize); i++ )
        {
            var idx = i
            
            if i >= Int(self.size) {
                idx = generateRandomDeckIndex(self.size)
            }
            self.deck.append(Card(rank: self.ranks[idx % 13], suit: self.suits[idx / 13]))
        }
        
        if bias != DeckBias.noBias {
            self.applyBias()
        }
        
        self.shuffle()
    }
    
    
    /**
     * Generate a random number
     *
     * @return 
     *      A random number between 0 and size of the deck minus 1
    */
    func generateRandomDeckIndex(deckSize: Int) -> Int {
        return Int(arc4random_uniform(UInt32(deckSize)))
    }
    
    
    
    /**
     * Shuffle the deck and reset the deck pointer
    */
    func shuffle() {
        self.deck.fullShuffle()
        self.deckPtr = -1
    }
    
    
    /**
     * Replace random cards in the deck with the card defined by the type of DeckBias
    */
    private func applyBias() {
        
        let numCardsToReplace: Int = self.customDeckSize / 16
        
        var i = 0;
        
        while ( i < numCardsToReplace ) {
        
            let suitIdx = generateRandomDeckIndex(self.size)
            let deckIdx = generateRandomDeckIndex(self.customDeckSize)
            
            let cardToReplaceWith: Card
            
            if self.bias == DeckBias.girlsDrinkMore {
                cardToReplaceWith = Card(rank: DeckBias.girlsDrinkMore.rawValue, suit: self.suits[suitIdx / 13])
            }
            else {
                cardToReplaceWith = Card(rank: DeckBias.guysDrinkMore.rawValue, suit: self.suits[suitIdx / 13] )
            }
            
            if self.deck[deckIdx].rank != cardToReplaceWith.rank {
                self.deck[deckIdx] = cardToReplaceWith
                i++
            }
            
        }
    }
    
    
    
    /*
     * Retrieve the next card from the deck if there is one
     *
     * @return 
     *      The next card in the card deck
    */
    func oneOffTheTop() -> Card? {
        if self.deckPtr >= Int(self.customDeckSize) - 1 {
            self.endOfDeck = true
            return nil
        }
        else if deck.count < 1 {
            return nil
        }
        
        let card = self.deck[++self.deckPtr]
        
        return card
    }
    
    
    /*!
     * Retrieves the previous card in the card deck
     *
     * @return 
     *      The previous card from the deck
    */
    func returnToTop() -> Card {
        if self.deckPtr <= 0 {
            self.deckPtr = 0
            return self.deck[self.deckPtr]
        }
        else if self.deckPtr > Int(self.customDeckSize) - 1 {
            self.deckPtr = Int(self.customDeckSize) - 1
        }
        
        return self.deck[--self.deckPtr]
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
    
    mutating func fullShuffle() {
        for i in 0...7 {
            self.shuffle()
        }
    }
}

