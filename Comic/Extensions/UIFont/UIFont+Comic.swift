//
//  UIFont+Comic.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

/**
 Accessors for all the fonts used.
 */
extension UIFont {
    
    class func tradeGothicLightWithSize(size: CGFloat) -> UIFont {
        
        return UIFont(name: "TradeGothic-Light", size: size * DeviceSizeService.sharedInstance.resizeFactor)!
    }
    
    class func tradeGothicLTWithSize(size: CGFloat) -> UIFont {
        
        return UIFont(name: "TradeGothicLT", size: size * DeviceSizeService.sharedInstance.resizeFactor)!
    }
    
    class func tradeGothicNo2BoldWithSize(size: CGFloat) -> UIFont {
        
        return UIFont(name: "TradeGothicNo.2-Bold", size: size * DeviceSizeService.sharedInstance.resizeFactor)!
    }
}