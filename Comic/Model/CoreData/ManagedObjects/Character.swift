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

    class func fetchCharacter(characterID:NSNumber,  managedObjectContext: NSManagedObjectContext) -> Character? {
        
        let predicate: NSPredicate = NSPredicate(format: "characterID == %@", characterID)
        
        let character: Character? = CDFRetrievalService.retrieveFirstEntryForEntityClass(Character.self, predicate: predicate, managedObjectContext: managedObjectContext) as? Character
        
        return character
    }
}
