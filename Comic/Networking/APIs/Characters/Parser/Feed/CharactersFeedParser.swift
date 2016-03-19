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
    
    func parseFeed(serverResponse: NSDictionary) -> CharacterFeed {
        
        let feed: CharacterFeed = CharacterFeed.fetchCharactersFeed(CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext)
        
        let data: NSDictionary = serverResponse["data"]! as! NSDictionary
        let total: NSNumber = data["total"]! as! NSNumber
        
        feed.totalCharacters = total
        
        let results: NSArray = data["results"]! as! NSArray
        
        let parser: CharactersParser = CharactersParser.parser()
        
        let characters: NSArray = parser.parseCharacters(results)
        
        for character in characters {
            
            (character as! Character).feed = feed
        }
        
        return feed
    }
}
