//
//  Character+CoreDataProperties.swift
//  
//
//  Created by Gabriel Massana on 19/3/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Character {

    @NSManaged var characterID: String?
    @NSManaged var name: String?
    @NSManaged var characterDescription: String?
    @NSManaged var modified: NSDate?
    @NSManaged var totalComics: NSNumber?
    @NSManaged var totalSeries: NSNumber?
    @NSManaged var totalStories: NSNumber?
    @NSManaged var totalEvents: NSNumber?
    @NSManaged var detailURL: String?
    @NSManaged var wikiURL: String?
    @NSManaged var comicLinkURL: String?
    @NSManaged var thumbnailPath: String?
    @NSManaged var thumbnailExtension: String?
    @NSManaged var feed: CharacterFeed?
}
