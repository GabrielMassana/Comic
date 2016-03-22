  //
//  Character.swift
//  
//
//  Created by Gabriel Massana on 19/3/16.
//
//

import Foundation
  
import CoreDataFullStack

@objc(Character)
  
public class Character: NSManagedObject {

    /**
     Retrieves character from DB based with ID provided.
     
     - parameter characterID: ID of character to be retrieved.
     - parameter managedObjectContext: context that should be used to access persistent store.
     
     - returns: Character instance or nil if character can't be found.
    */
    class func fetchCharacter(characterID:NSNumber,  managedObjectContext: NSManagedObjectContext) -> Character? {
        
        let predicate: NSPredicate = NSPredicate(format: "characterID == %@", characterID)
        
        let character: Character? = CDFRetrievalService.retrieveFirstEntryForEntityClass(Character.self, predicate: predicate, managedObjectContext: managedObjectContext) as? Character
        
        return character
    }
}
