//
//  Parser.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

/**
 Abstract parser instance with a class function to init it.
 */
class Parser: NSObject {

    //MARK: - Init
    
    required override init() {
        
        super.init()
    }
    
    class func parser() -> Self  {
        
        return self.init()
    }
}
