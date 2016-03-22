//
//  DeviceSizeService.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

let iPhone5Width: CGFloat = 320.0

/**
 The singleton returns the factor to resize iPhone 6 and iPhone 6+ to the correct assets sizes.
 */
class DeviceSizeService: NSObject {

    /**
     Singleton.
     
     - returns: DeviceSizeService instance
     */
    static let sharedInstance = DeviceSizeService()

    /**
     The factor should be used to resize assets and fonts.
     */
    let resizeFactor: CGFloat = UIScreen.mainScreen().bounds.size.width / iPhone5Width
    
    private override init() {
        
    }
}
