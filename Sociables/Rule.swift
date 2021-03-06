//
//  Rule.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-05-03.
//  
//

import Foundation
import CoreData

@objc(Rule)
class Rule: NSManagedObject {

    @NSManaged var rank: String
    @NSManaged var explanation: String
    @NSManaged var title: String


    static let ruleRankKey = "rank"
    static let ruleTitleKey = "title"
    static let ruleExplanationKey = "explanation"
}
