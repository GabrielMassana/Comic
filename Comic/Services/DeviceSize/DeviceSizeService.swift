//
//  DeviceSizeService.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

let iPhone5Width: CGFloat = 320.0

class DeviceSizeService: NSObject {

    static let sharedInstance = DeviceSizeService()

    let resizeFactor: CGFloat = UIScreen.mainScreen().bounds.size.width / iPhone5Width
    
    private override init() {
        
    }
}
