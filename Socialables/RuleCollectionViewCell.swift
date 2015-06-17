//
//  RuleCollectionViewCell.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  
//

import UIKit


protocol CellActionDelegate {
    func buttonPressed(cell: RuleCollectionViewCell, action: String)
}



class RuleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var ruleTitle: UILabel!
    @IBOutlet weak var ruleText: UILabel!
    
    
    var delegate: CellActionDelegate?
    
    
    @IBAction func editButtonPressed() {
        delegate?.buttonPressed(self, action: "edit")
    }
    
}
