//
//  ViewController.swift
//  Socialables
//
//  Created by CIS-Mac-16 on 2015-03-08.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit


class GameViewController: UIViewController, ENSideMenuDelegate {

    @IBOutlet weak var cardImage : UIImageView!
    @IBOutlet weak var cardRule : UILabel!
    @IBOutlet weak var cardTitle : UILabel!
    

    let deck = CardDeck()
    let rules = RuleManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector( "handleCardSwipe:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector( "handleCardSwipe:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer( leftSwipe )
        view.addGestureRecognizer( rightSwipe )
        
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func toggleMenu(action: AnyObject) {
        toggleSideMenuView()
    }
    
    
    /*
     * Handle menu events that do not result in a change of view Controllers
    */
    func nonSegueEventDidFire(action: AnyObject) {
        let event = action as! String

        if event == "New Game" {
            self.startNewGame()
        }
    }
    
    
    /*
     * When a swipe event is fired, run appropriate actions against card deck
    */
    func handleCardSwipe( sender: UISwipeGestureRecognizer )
    {
        var card : Card?
        
        
        if sender.direction == .Left
        {
            card = self.deck.oneOffTheTop()
        }
        else if sender.direction == .Right
        {
            card = self.deck.returnToTop()
        }
            
        if card != nil
        {
            let rank : String! = card?.rank
            let suit : String! = card?.suit
            let imgName = rank + "_of_" + suit

            self.cardImage.image = UIImage( named: imgName )
            let rule = rules.getRule(rank)
            self.cardTitle.text = rule.name
            self.cardRule.text = rule.explanation
            
            return
        }
        else if sender.direction == .Left && self.deck.endOfDeck {
            // end of deck reached
            var alert = UIAlertController(title: "Gameover!", message: "You've reached the end of the deck. Did you want to play another round?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: handleNewGameOkayButtonPressed))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func handleNewGameOkayButtonPressed( alert: UIAlertAction? ) {
        self.startNewGame()
    }
    
    
    func startNewGame()
    {
        self.deck.shuffle()
        self.cardImage.image = UIImage( named: "top" )
        
    }
    
}

