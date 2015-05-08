//
//  SettingsViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var girlsDrinkMoreSwitch: UISwitch!
    @IBOutlet weak var guysDrinkMoreSwitch: UISwitch!
    @IBOutlet weak var deckSizeSlider: UISlider!
    
    
    let settings = Settings.sharedInstance
    
    
    
    override func viewDidLoad() {

        let bias = settings.getBias()
        deckSizeSlider.value = Float(settings.getDeckSize())
        
        println(bias.hashValue)
        
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
    
    
    
    @IBAction func girlsDrinkMoreSwitchChanged(sender: UISwitch) {
        if sender.on {
            
            guysDrinkMoreSwitch.setOn(false, animated: true)
            settings.setBias(DeckBias.guysDrinkMore, value: false)
            settings.setBias(DeckBias.girlsDrinkMore, value: true)
            
        } else {
            settings.setBias(DeckBias.girlsDrinkMore, value: false)
        }
    }
    
    @IBAction func guysDrinkMoreSwitchChanged(sender: UISwitch) {
        if sender.on {
            
            girlsDrinkMoreSwitch.setOn(false, animated: true)
            settings.setBias(DeckBias.girlsDrinkMore, value: false)
            settings.setBias(DeckBias.guysDrinkMore, value: true)
            
        } else {
            settings.setBias(DeckBias.guysDrinkMore, value: false)
        }
    }
    
    @IBAction func numberSliderDidChange(sender: UISlider) {
        settings.setDeckSize(Int(sender.value))
    }
    
    
}
