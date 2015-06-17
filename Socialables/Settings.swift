//
//  Settings.swift
//  Sociables
//
//  Created by Francis Bailey on 2015-05-05.
//  
//

import Foundation


protocol SettingsDelegate {
    func settingsDidChange()
}



class Settings {
    
    let settingsDB: NSUserDefaults
    let notificationKey = "settingsChanged"
    
    static let sharedInstance = Settings()
    
    
    let girlsDrinkMore  = ("girlsDrinkMore", false)
    let guysDrinkMore   = ("guysDrinkMore", false)
    let defaultDeckSize = ("deckSize", 52)
    
    var delegate: SettingsDelegate?
    
    
    
    init() {
        settingsDB = NSUserDefaults.standardUserDefaults()
    }
    
    
    internal func save(key: String, value: AnyObject) {
        settingsDB.setObject(value, forKey: key)
         NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: self)
    }
    
    
    /*
     * Set the number of cards in the card deck
    */
    func setDeckSize(size: Int) {
        save(defaultDeckSize.0, value: size)
        delegate?.settingsDidChange()
    }
    
    
    /*
     * Determine the type of Bias the deck may have and convert it to a boolean 
     * value to be stored in user defaults
    */
    func setBias(bias: DeckBias, value: Bool) {
        
        switch bias {
        
        case .girlsDrinkMore:
            save(girlsDrinkMore.0, value: value)
            break
        
        case .guysDrinkMore:
            save(guysDrinkMore.0, value: value)
            break
            
        case .noBias:
            save(girlsDrinkMore.0, value: false)
            save(guysDrinkMore.0, value: false)
            break
            
        default:
            save(girlsDrinkMore.0, value: false)
            save(guysDrinkMore.0, value: false)
        }
        
    }
    
    
    /*
     * Retrieve both bias types to determine if there is a bias
     * in the deck and return the corresponding bias
    */
    func getBias() -> DeckBias {
        
        let value: String
        
        let girlBias: AnyObject? = settingsDB.objectForKey(girlsDrinkMore.0)
        let guyBias: AnyObject? = settingsDB.objectForKey(guysDrinkMore.0)
        
        
        if girlBias != nil && (girlBias as! Bool) {
             return DeckBias.girlsDrinkMore
        }
        else if guyBias != nil && (guyBias as! Bool) {
              return DeckBias.guysDrinkMore
        }
        else {
            return DeckBias.noBias
        }
    }
    
    
    func getDeckSize() -> Int {
        
        if let size: AnyObject = settingsDB.objectForKey(defaultDeckSize.0) {
            return size as! Int
        } else {
            save(defaultDeckSize.0, value: defaultDeckSize.1)
            return defaultDeckSize.1
        }
    }
    
    
}