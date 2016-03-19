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

    func parseCharacters(charactersResponse: NSArray) -> NSArray {
        
        print(charactersResponse)
        
        let charactersArray: NSMutableArray = NSMutableArray(capacity: charactersResponse.count)
        
            do {
                
                for characterResponse in charactersResponse {
                    
                    let characterDictionary: NSDictionary = characterResponse as! NSDictionary
                    
                    charactersArray.addObject(self.parseCharacter(characterDictionary))
                }
                
                try CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.save()
            }
            catch
            {
                print(error)
            }
        
        return charactersArray
    }
    
    //MARK: - ParseCharacter

    func parseCharacter(characterResponse: NSDictionary) -> Character {
        
        let character:Character = CDFInsertService.insertNewObjectForEntityClass(Character.self, inManagedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext) as! Character
        
//        let feed: CharacterFeed = CharacterFeed.fetchCharactersFeed(CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext)
        
        
        
        return character
    }
}
