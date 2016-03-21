//
//  CharactersParserTests.swift
//  Comic
//
//  Created by GabrielMassana on 21/03/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import XCTest

@testable import Comic

import CoreDataFullStack

class CharactersParserTests: XCTestCase, CDFCoreDataManagerDelegate {

    //MARK: - Accessors

    var parser: CharactersParser?
    
    var characterJSON: NSDictionary?
    
    var characterID: NSNumber?
    
    //MARK: - CDFCoreDataManagerDelegate
    
    internal func coreDataModelName() -> String! {
        
        return "Marvel"
    }
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        
        super.setUp()
        
        CDFCoreDataManager.sharedInstance().delegate = self
        
        parser = CharactersParser(managedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext)
        
        characterID = NSNumber(int: 1011097)
        
        characterJSON = [
            "id": characterID!,
            "name": "Captain Marvel (Phyla-Vell)",
            "description": "",
            "modified": "1969-12-31T19:00:00-0500",
            "thumbnail": [
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/4c0030bc4629e",
                "extension": "jpg"
            ],
            "comics": [
                "available": 10,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/comics",
                "items": [
                    
                ],
                "returned": 10
            ],
            "series": [
                "available": 20,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/series",
                "items": [
                    
                ],
                "returned": 20
            ],
            "stories": [
                "available": 40,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/stories",
                "items": [
                    
                ],
                "returned": 20
            ],
            "events": [
                "available": 0,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/events",
                "items": [
                    
                ],
                "returned": 0
            ],
            "urls": [
                [
                    "type": "detail",
                    "url": "http://marvel.com/characters/9/captain_marvel?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
                ],
                [
                    "type": "wiki",
                    "url": "http://marvel.com/universe/Quasar_(Phyla-Vell)?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
                ],
                [
                    "type": "comiclink",
                    "url": "http://marvel.com/comics/characters/1011097/captain_marvel_phyla-vell?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
                ]
            ]
        ]
    }
    
    override func tearDown() {
        
        CDFCoreDataManager.sharedInstance().reset()
        
        parser = nil
        
        characterJSON = nil
        
        super.tearDown()
    }
    
    // MARK: - CharacterParser
    
    func test_parseCharacter_newCharacterObjectReturned() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertNotNil(character, "A valid Character object wasn't created");
    }

    func test_parseConversation_alreadyInsertedConversationObjectReturned() {
        
        let insertedCharacter: Comic.Character? = CDFInsertService.insertNewObjectForEntityClass(Character.self, inManagedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext) as? Comic.Character
        
        insertedCharacter!.characterID = characterID!.stringValue
        
        do {
            
            try CDFCoreDataManager.sharedInstance().managedObjectContext.save()
        }
        catch
        {
            print(error)
        }
        
        /*-------------------*/

        let parsedCharacter = parser?.parseCharacter(characterJSON!)

        XCTAssertEqual(insertedCharacter!.objectID, parsedCharacter!.objectID,  "Should have returned the existing Character");
    }
    
    // MARK: - CharactersParser

}
