//
//  Parser.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack

/**
 Abstract parser instance with a class function to init it.
 */
class Parser: NSObject {

    //MARK: - Accessors

    var parserManagedObjectContext: NSManagedObjectContext?
    
    //MARK: - Init
    
    required init(managedObjectContext: NSManagedObjectContext) {
        
        super.init()
        
        parserManagedObjectContext = managedObjectContext

    }
    
    class func parser(managedObjectContext: NSManagedObjectContext) -> Self  {
        
        return self.init(managedObjectContext: managedObjectContext)
    }
}
