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

    var charactersResponse: NSDictionary?
    
    //MARK: - Init
    
    init(charactersResponse: NSDictionary) {
        
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
            
            let feedParser: CharactersFeedParser = CharactersFeedParser.parser()
            
            if let response = self.charactersResponse {
                
                let feed: CharacterFeed = feedParser.parseFeed(response)
                
                do {
                    try CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.save()
                    
                    self.didSucceedWithResult(feed.feedID)
                }
                catch
                {
                    print(error)
                    self.didFailWithError(nil)
                }
            }
            else
            {
                // Failure
                self.didFailWithError(nil)
            }
        }
    }
    
    //MARK: - Cancel
    
    override func cancel() {
        
        super.cancel()
        
        didSucceedWithResult(nil)
    }
}
