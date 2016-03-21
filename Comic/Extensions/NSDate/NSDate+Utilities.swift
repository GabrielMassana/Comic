//
//  NSDate+Utilities.swift
//  Comic
//
//  Created by GabrielMassana on 21/03/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import Foundation

extension NSDate {
    
    func isDateOneHourOrMoreAgo() -> Bool {
    
        var isDateOneHourOrMoreAgo = false
    
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.hour = 1
        
        let lastServerFailurePlusOneHour: NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions.WrapComponents)!
        
        if (lastServerFailurePlusOneHour.timeIntervalSinceReferenceDate > NSDate().timeIntervalSinceReferenceDate) {
            
            isDateOneHourOrMoreAgo = true
        }
    
        return isDateOneHourOrMoreAgo
    }
}