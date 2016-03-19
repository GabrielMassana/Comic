//
//  CharacterFeed.swift
//  
//
//  Created by Gabriel Massana on 19/3/16.
//
//

import Foundation

import CoreDataFullStack

let CharactersFeedID: String = "-1"

@objc(CharacterFeed)
class CharacterFeed: NSManagedObject {

    private class func fetchCharactersFeed(feedID:String,  managedObjectContext: NSManagedObjectContext) -> CharacterFeed? {
        
        let predicate: NSPredicate = NSPredicate(format: "feedID MATCHES %@", feedID)
        
        let feed: CharacterFeed? = CDFRetrievalService.retrieveFirstEntryForEntityClass(CharacterFeed.self, predicate: predicate, managedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext) as? CharacterFeed

        return feed
    }
    
    class func fetchCharactersFeed(managedObjectContext: NSManagedObjectContext) -> CharacterFeed {
        
        var feed: CharacterFeed? = CharacterFeed.fetchCharactersFeed(CharactersFeedID, managedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext)
        
        if let aFeed: CharacterFeed = feed {
            
            return aFeed
        }
        else
        {
            feed = CDFInsertService.insertNewObjectForEntityClass(CharacterFeed.self, inManagedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext) as? CharacterFeed
            
            feed!.feedID = CharactersFeedID
            
            return feed!
        }
    }
}
