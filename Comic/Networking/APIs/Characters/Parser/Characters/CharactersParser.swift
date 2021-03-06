//
//  CharactersParser.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack

class CharactersParser: Parser {

    //MARK: - ParseCharacters

    /**
    Parse a characters response from the Marvel API.
    
    - parameter charactersResponse: a characters response from the Marvel API
    
    - returns: An array with Character objects parsed.
    */
    func parseCharacters(charactersResponse: NSArray) -> NSArray {
        
        let charactersArray: NSMutableArray = NSMutableArray(capacity: charactersResponse.count)
        
        for characterResponse in charactersResponse {
            
            let characterDictionary: NSDictionary = characterResponse as! NSDictionary
            
            let character: Character? = self.parseCharacter(characterDictionary)
            
            if character != nil {
                
                charactersArray.addObject(character!)
            }
        }
        
        return charactersArray
    }
    
    //MARK: - ParseCharacter

    /**
    Parse an character response from the Marvel API.

    - parameter characterResponse: a character response from the Marvel API

    - returns: A Character object parsed.
    */
    func parseCharacter(characterResponse: NSDictionary) -> Character? {
        
        let characterID: NSNumber? = characterResponse["id"] as? NSNumber
        
        var character: Character?
        
        if let _ = characterID {
            
            character = Character.fetchCharacter(characterID!, managedObjectContext: parserManagedObjectContext!)
         
            if (character == nil)
            {
                character = CDFInsertService.insertNewObjectForEntityClass(Character.self, inManagedObjectContext: parserManagedObjectContext!) as? Character
            
                character?.characterID = characterID?.stringValue
            }
            
            character?.name = characterResponse["name"] as? String
            character?.characterDescription = characterResponse["description"] as? String
            
            let thumbnail: NSDictionary? = characterResponse["thumbnail"] as? NSDictionary
            let comics: NSDictionary? = characterResponse["comics"] as? NSDictionary
            let series: NSDictionary? = characterResponse["series"] as? NSDictionary
            let stories: NSDictionary? = characterResponse["stories"] as? NSDictionary
            let events: NSDictionary? = characterResponse["events"] as? NSDictionary
            let urls: NSArray? = characterResponse["urls"] as? NSArray
            
            if let _ = thumbnail {
                
                character?.thumbnailExtension = thumbnail!["extension"] as? String
                character?.thumbnailPath = thumbnail!["path"] as? String
            }
            
            if let _ = comics {
                
                character?.totalComics = comics!["available"] as? NSNumber
            }
            
            if let _ = series {
                
                character?.totalSeries = series!["available"] as? NSNumber
            }
            
            if let _ = stories {
                
                character?.totalStories = stories!["available"] as? NSNumber
            }
            
            if let _ = events {
                
                character?.totalEvents = events!["available"] as? NSNumber
            }
            
            character?.detailURL = ""
            character?.wikiURL = ""
            character?.comicLinkURL = ""

            if let _ = urls {
                
                for url in urls! {
                    
                    if (url as! NSDictionary)["type"] as! String == "detail" {
                        
                        character?.detailURL = (url as! NSDictionary)["url"] as? String
                    }
                    else if (url as! NSDictionary)["type"] as! String == "wiki"
                    {
                        character?.wikiURL = (url as! NSDictionary)["url"] as? String
                    }
                    else if (url as! NSDictionary)["type"] as! String == "comiclink"
                    {
                        character?.comicLinkURL = (url as! NSDictionary)["url"] as? String
                    }
                }
            }
            
            let modified: String? = characterResponse["modified"] as? String

            if let _ = modified {
                
                let dateFormatter: NSDateFormatter = NSDateFormatter.serverDateFormatter()

                character?.modified = dateFormatter.dateFromString(modified!)
            }
        }
        
        return character
    }
}
