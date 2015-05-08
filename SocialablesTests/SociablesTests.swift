//
//  SocialablesTests.swift
//  SocialablesTests
//
//  Created by Francis Bailey on 2015-03-08.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit
import XCTest

class SocialablesTests: XCTestCase {

    
    let deck = CardDeck.sharedInstance
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /*
     * Test that the deck has at least 13 cards for each rank on any
     * given shuffle, with any deck size >= 52
    */
    func testAllCardsInDeck() {
        
        deck.shuffle()
        
        let cards = deck.deck
        
        var ranks = [String: Int]()
        var suits = [String: Int]()
        
        
        for rank in deck.ranks {
            ranks.updateValue(0, forKey: rank)
        }
        
        for suit in deck.suits {
            suits.updateValue(0, forKey: suit)
        }
        
        
        for card in cards {
            var rank = ranks[card.rank]!
            var suit = suits[card.suit]!
            
          
            ranks[card.rank] = rank < 1 ? 1 : ++rank
            suits[card.suit] = suit < 1 ? 1 : ++suit
        }
        
        
        for rank in ranks {
            XCTAssertGreaterThanOrEqual(rank.1, 4, "Assert there are 4 cards of each type in deck")
        }
        
        
        for suit in suits {
            XCTAssertGreaterThanOrEqual(suit.1, 13, "Assert there are 13 of each suit in the deck")
        }
        
    }
    
    
    
    
  
    
}
