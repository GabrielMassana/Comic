//
//  CharactersFeedParser.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack

class CharactersFeedParser: Parser {

    //MARK: - ParseFeed
    
    /**
    Parse a feed response from the Marvel API.
    
    - parameter serverResponse: a feed response from the Marvel API
    
    - returns: A CharacterFeed objects parsed.
    */
    func parseFeed(serverResponse: NSDictionary) -> CharacterFeed {
        
        let feed: CharacterFeed = CharacterFeed.fetchCharactersFeed(parserManagedObjectContext!)
        
        let data: NSDictionary? = serverResponse["data"] as? NSDictionary
        
        if let _ = data {
            
            let total: NSNumber? = data!["total"]! as? NSNumber
            
            feed.totalCharacters = total
            
            let results: NSArray? = data!["results"] as? NSArray
            
            if let _ = results {
                
                let parser: CharactersParser = CharactersParser.parser(parserManagedObjectContext!)
                
                let characters: NSArray = parser.parseCharacters(results!)
                
                for character in characters {
                    
                    (character as! Character).feed = feed
                }
            }
        }
        else
        {
            feed.lastServerFailure = NSDate()
        }
        
        return feed
    }
}
