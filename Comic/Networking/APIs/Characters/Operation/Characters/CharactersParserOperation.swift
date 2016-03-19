//
//  CharactersParserOperation.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreOperation
import CoreDataFullStack

class CharactersParserOperation: COMOperation {

    //MARK: - Accessors

    var charactersResponse: NSArray?
    
    //MARK: - Init
    
    init(charactersResponse: NSArray) {
        
        super.init()
        
        self.charactersResponse = charactersResponse
    }
    
    override init() {
        
        super.init()
        
        identifier = "CharactersParserOperation"
    }
    
    //MARK: - Start
    
    override func start() {
        
        super.start()
        
        CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.performBlockAndWait { () -> Void in
            
            let parser: CharactersParser = CharactersParser.parser()
            
            if let _ = self.charactersResponse {
                
                parser.parseCharacters(self.charactersResponse!)
            }
        }
        
        didSucceedWithResult("")
    }
    
    //MARK: - Cancel
    
    override func cancel() {
        
        super.cancel()
        
        didSucceedWithResult(nil)
    }
}
