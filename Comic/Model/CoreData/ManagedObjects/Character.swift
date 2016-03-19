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
class Character: NSManagedObject {

    class func fetchCharacter(characterID:NSNumber,  managedObjectContext: NSManagedObjectContext) -> Character? {
        
        let predicate: NSPredicate = NSPredicate(format: "characterID == %@", characterID)
        
        let feed: Character? = CDFRetrievalService.retrieveFirstEntryForEntityClass(Character.self, predicate: predicate, managedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext) as? Character
        
        return feed
    }
}
