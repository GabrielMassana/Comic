//
//  UIColor+Hex.swift
//  Comic
//
//  Created by GabrielMassana on 18/03/2016.
//  Copyright © 2016 GabrielMassana. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorWithHex(hex: String) -> UIColor? {
        
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        
        var color:UIColor? = nil
        
        let noHash = hex.stringByReplacingOccurrencesOfString("#", withString: "")
        
        let start = noHash.startIndex
        let hexColor = noHash.substringFromIndex(start)

        if hexColor.characters.count == 6 {
            
            let scanner = NSScanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexLongLong(&hexNumber) {
                
                red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                blue = CGFloat(hexNumber & 0x0000ff) / 255
                
                color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            }
        }
        
        return color
    }
    
    class func colorWithHexAlpha(hex: String) -> UIColor? {
        
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        
        var color:UIColor? = nil
        
        let noHash = hex.stringByReplacingOccurrencesOfString("#", withString: "")
        
        let start = noHash.startIndex
        let hexColor = noHash.substringFromIndex(start)
        
        if hexColor.characters.count == 6 {
            
            let scanner = NSScanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexLongLong(&hexNumber) {
                
                red = CGFloat((hexNumber & 0xff000000) >> 32) / 255
                green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000ff) / 255
                
                color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        }
        
        return color
    }
}
