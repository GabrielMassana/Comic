//
//  CharacterFeed+CoreDataProperties.swift
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

extension CharacterFeed {

    @NSManaged var feedID: String?
    @NSManaged var characters: NSSet?
    @NSManaged var totalCharacters: NSNumber?
    @NSManaged var lastServerFailure: NSDate?
}
