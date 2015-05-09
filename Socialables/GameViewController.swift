//
//  ViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-03-08.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit


class GameViewController: UIViewController, NavControllerDelegate, SettingsDelegate {

    @IBOutlet weak var cardImage : UIImageView!
    @IBOutlet weak var topRank: UILabel!
    @IBOutlet weak var bottomRank: UILabel!
    @IBOutlet weak var topSuit: UIImageView!
    @IBOutlet weak var bottomSuit: UIImageView!
    
    @IBOutlet weak var cardCount: UILabel!
    @IBOutlet weak var cardRule : UILabel!
    @IBOutlet weak var cardTitle : UILabel!
    

    let deck = CardDeck.sharedInstance
    let rules = RuleManager.sharedInstance
    let settings = Settings.sharedInstance
    
    var newGame: Bool = true
    
    
    let redTextColor = UIColor(red: 230, green: 0, blue: 0, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bottomRank.layer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
        bottomSuit.layer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
        
        deck.setDeckBias(settings.getBias())
        deck.setDeckSize(settings.getDeckSize())
        deck.buildDeck()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector( "handleCardSwipe:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector( "handleCardSwipe:"))
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleCardTap:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        cardImage.userInteractionEnabled = true;
        
        view.addGestureRecognizer( leftSwipe )
        view.addGestureRecognizer( rightSwipe )
        cardImage.addGestureRecognizer(tapGesture)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "settingsDidChange", name: settings.notificationKey, object: nil)
        
        let nav = self.navigationController as? NavController
        nav?.customDelegate = self
    }
    

    
    /*
     * Handle menu button press in UI
    */
    @IBAction func toggleMenu(action: AnyObject) {
        toggleSideMenuView()
    }
    
    
    /*
     * Handle menu events that do not result in a change of view Controllers
    */
    func menuEventDidFire(action: AnyObject) {
        let event = action as! String

        if event == "New Game" {
            self.startNewGame()
        }
    }
    
    
    func handleCardTap( sender: UITapGestureRecognizer ) {
        
        let card: Card?
        
        if sender.state == .Ended {
            card = self.deck.oneOffTheTop()
            
            if let c = card {
                updateCardView(c)
            }
            else if self.deck.endOfDeck {
                showGameOverAlert()
            }
        }
        
        
        
    }
    
    
    func updateCardView( card: Card ) {
        
        if newGame {
            self.cardImage.image = UIImage(named: "blank-card")
            newGame = false
        }
        
        
        let textColor: UIColor!
        var rank : String! = card.rank
        let suit : String! = card.suit
        
        let img = UIImage(named: suit)
        
        let rule = rules.getRule(rank)
        
        if (rank?.toInt() == nil) {
            rank = rank.substringToIndex(advance(rank.startIndex, 1)).capitalizedString
        }
        
        if suit == "hearts" || suit == "diamonds" {
            textColor = redTextColor
        }
        else {
            textColor = UIColor.blackColor()
        }
        
        self.topSuit.image = img
        self.bottomSuit.image = img
        
        
        self.topRank.text = rank
        self.bottomRank.text = rank
        
        self.topRank.textColor = textColor
        self.bottomRank.textColor = textColor
        
        self.cardTitle.textColor = textColor
        self.cardRule.textColor = textColor
        self.cardTitle.text = rule.rule.title
        self.cardRule.text = rule.rule.explanation

        self.cardCount.textColor = textColor
        self.cardCount.text = "\(self.deck.getDeckPtr())/\(self.deck.getDeckSize())"
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
        else if sender.state == .Ended {
            card = self.deck.oneOffTheTop()
        }
            
        if let c = card {
            updateCardView(c)
        }
        else if sender.direction == .Left && self.deck.endOfDeck {
            showGameOverAlert()
        }
        
    }
    
    
    /*
     * Initialize and show alert corresponding to the end of a game
    */
    func showGameOverAlert() {
        var alert = UIAlertController(title: "Gameover!", message: "You've reached the end of the deck. Did you want to play another round?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: handleNewGameOkayButtonPressed))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /*
     * When settings have changed, this function is called automatically
     * updating the deck with the latest changes
    */
    func settingsDidChange() {
        deck.setDeckBias(settings.getBias())
        deck.setDeckSize(settings.getDeckSize())
        
        // Add prompt to see if deck should be reloaded after settings changed
        deck.buildDeck()
        self.startNewGame()
    }
    
    
    /*
     * Method that handles button press from UIAlertController
    */
    func handleNewGameOkayButtonPressed( alert: UIAlertAction? ) {
        self.startNewGame()
    }
    
    
    func startNewGame()
    {
        self.cardImage.image = UIImage(named: "start-card")
        self.deck.shuffle()
        self.topRank.text = ""
        self.bottomRank.text = ""
        self.bottomSuit.image = nil
        self.topSuit.image = nil
        self.cardRule.text = ""
        self.cardTitle.text = ""
        self.cardCount.text = ""
        
        newGame = true
        
    }
    
}

