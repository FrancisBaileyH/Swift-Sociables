//
//  SettingsViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  
//

import UIKit



class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var girlsDrinkMoreSwitch: UISwitch!
    @IBOutlet weak var guysDrinkMoreSwitch: UISwitch!
    @IBOutlet weak var deckSizeSlider: UISlider!
    @IBOutlet weak var deckSizeLabel: UILabel!
    
    
    let settings = Settings.sharedInstance
    let rm = RuleManager.sharedInstance
    
    var girlDrinksCardIsDefault: CardAndRuleType? = nil
    var guyDrinksCardIsDefault: CardAndRuleType? = nil
    
    
    override func viewDidLoad() {
        
        let initialDeckSize = Float(settings.getDeckSize())
        deckSizeSlider.value = initialDeckSize
        deckSizeLabel.text = String(stringInterpolationSegment: Int(initialDeckSize))
        
        
        let bias = settings.getBias()
              
        if checkIfCustomValue() || bias == DeckBias.noBias {
            switch bias {
          
            case DeckBias.girlsDrinkMore:
                girlsDrinkMoreSwitch.setOn(true, animated: false)
                guysDrinkMoreSwitch.setOn(false, animated: false)
                break
    
            case DeckBias.guysDrinkMore:
                girlsDrinkMoreSwitch.setOn(false, animated: false)
                guysDrinkMoreSwitch.setOn(true, animated: false)
                break
            
            default:
                girlsDrinkMoreSwitch.setOn(false, animated: false)
                guysDrinkMoreSwitch.setOn(false, animated: false)
            }
        }
        else {
            setAllSwitchesToFalse()
            showAlertIfNotDefaultOnSet()
        }
    }
    
    
    /*
     *  Check to see if the cards required for making a gender drink more are default or not.
     *  If they aren't default we'll want to warn the user and prevent any action from occurring
     *  on these respective switches
    */
    func checkIfCustomValue() -> Bool {
        
        girlDrinksCardIsDefault = rm.getRule(rm.defaultGirlsDrinkCard)
        guyDrinksCardIsDefault = rm.getRule(rm.defaultGuysDrinkCard)
        
        if !girlDrinksCardIsDefault!.isDefault || !guyDrinksCardIsDefault!.isDefault {
            return false
        }
        else {
            return true
        }
    }
    
    
    
    func setAllSwitchesToFalse() {
        guysDrinkMoreSwitch.setOn(false, animated: true)
        girlsDrinkMoreSwitch.setOn(false, animated: true)

        settings.setBias(DeckBias.noBias, value: true)
    }
    
    
    
    @IBAction func girlsDrinkMoreSwitchChanged(sender: UISwitch) {
        
        if sender.on {
            if !checkIfCustomValue() {
                setAllSwitchesToFalse()
                showAlertIfNotDefaultOnSet()
                return
            }
            
            guysDrinkMoreSwitch.setOn(false, animated: true)
            settings.setBias(DeckBias.guysDrinkMore, value: false)
            settings.setBias(DeckBias.girlsDrinkMore, value: true)
            
        }
        else {
            settings.setBias(DeckBias.girlsDrinkMore, value: false)
        }
    }
    
    
    @IBAction func guysDrinkMoreSwitchChanged(sender: UISwitch) {
        
        if sender.on {
            
            if !checkIfCustomValue() {
                setAllSwitchesToFalse()
                showAlertIfNotDefaultOnSet()
                return
            }
            
            girlsDrinkMoreSwitch.setOn(false, animated: true)
            settings.setBias(DeckBias.guysDrinkMore, value: true)
            settings.setBias(DeckBias.girlsDrinkMore, value: false)
            
        }
        else {
            settings.setBias(DeckBias.guysDrinkMore, value: false)
        }
    }
    
    
    @IBAction func numberSliderDidChange(sender: UISlider) {
        
        let roundedValue = Int(sender.value)
        
        deckSizeLabel.text = String(stringInterpolationSegment: roundedValue)
        settings.setDeckSize(roundedValue)
    }
    
    
    
    /*
     * Show an alert when the 6 and 4 card have their own custom values
     * as the game relies on those two cards to make girls drink more
     * or make guys drink more.
    */
    func showAlertIfNotDefaultOnSet()  {
        
        let warning = UIAlertController(title: "Custom Rule Found", message: "Cards 4 and 6 need to be set to their default values in order to use the girls/guys drink more setting.", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        warning.addAction(OKAction)
        self.presentViewController(warning, animated: true, completion: nil)
    }
    
    
    
}
