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
    var characterName: String?
    var characterDescription: String?
    var modified: String?
    var totalComics: NSNumber?
    var totalSeries: NSNumber?
    var totalStories: NSNumber?
    var totalEvents: NSNumber?
    var detailURL: String?
    var wikiURL: String?
    var comicLinkURL: String?
    var thumbnailPath: String?
    var thumbnailExtension: String?
    
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
        characterName = "Captain Marvel (Phyla-Vell)"
        characterDescription = "characterDescription"
        modified = "1969-12-31T19:00:00-0500"
        totalComics = NSNumber(int: 10)
        totalSeries = NSNumber(int: 20)
        totalStories = NSNumber(int: 40)
        totalEvents = NSNumber(int: 0)
        detailURL = "http://marvel.com/characters/9/captain_marvel?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
        wikiURL = "http://marvel.com/universe/Quasar_(Phyla-Vell)?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
        comicLinkURL = "http://marvel.com/comics/characters/1011097/captain_marvel_phyla-vell?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
        thumbnailPath = "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/4c0030bc4629e"
        thumbnailExtension = "jpg"
        
        characterJSON = [
            "id": characterID!,
            "name": characterName!,
            "description": characterDescription!,
            "modified": modified!,
            "thumbnail": [
                "path": thumbnailPath!,
                "extension": thumbnailExtension!
            ],
            "comics": [
                "available": totalComics!,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/comics",
                "items": [
                    
                ],
                "returned": 10
            ],
            "series": [
                "available": totalSeries!,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/series",
                "items": [
                    
                ],
                "returned": 20
            ],
            "stories": [
                "available": totalStories!,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/stories",
                "items": [
                    
                ],
                "returned": 20
            ],
            "events": [
                "available": totalEvents!,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011097/events",
                "items": [
                    
                ],
                "returned": 0
            ],
            "urls": [
                [
                    "type": "detail",
                    "url": detailURL!
                ],
                [
                    "type": "wiki",
                    "url": wikiURL!
                ],
                [
                    "type": "comiclink",
                    "url": comicLinkURL!
                ]
            ]
        ]
    }
    
    override func tearDown() {
        
        CDFCoreDataManager.sharedInstance().reset()
        
        parser = nil
        
        characterJSON = nil
        
        characterID = nil
        characterName = nil
        characterDescription = nil
        modified = nil
        totalComics = nil
        totalSeries = nil
        totalStories = nil
        totalEvents = nil
        detailURL = nil
        wikiURL = nil
        comicLinkURL = nil
        thumbnailPath = nil
        thumbnailExtension = nil
        
        super.tearDown()
    }
    
    // MARK: - CharacterParser
    
    func test_parseCharacter_newCharacterObjectReturned() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertNotNil(character, "A valid Character object wasn't created");
    }

    func test_parseCharacter_alreadyInsertedCharacterObjectReturned() {
        
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
    
    func test_parseCharacter_characterID() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.characterID! == characterID!.stringValue, String(format:"characterID property was not set properly. Was set to: %@ rather than: %@", character!.characterID!, characterID!.stringValue));
    }
    
    func test_parseCharacter_name() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.name! == characterName!, String(format:"name property was not set properly. Was set to: %@ rather than: %@", character!.name!, characterName!));
    }
    
    func test_parseCharacter_characterDescription() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.characterDescription! == characterDescription!, String(format:"characterDescription property was not set properly. Was set to: %@ rather than: %@", character!.characterDescription!, characterDescription!));
    }
    
    func test_parseCharacter_totalComics() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.totalComics == totalComics, String(format:"totalComics property was not set properly. Was set to: %@ rather than: %@", character!.totalComics!, totalComics!));
    }
    
    func test_parseCharacter_totalSeries() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.totalSeries == totalSeries, String(format:"totalSeries property was not set properly. Was set to: %@ rather than: %@", character!.totalSeries!, totalSeries!));
    }
    
    func test_parseCharacter_totalStories() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.totalStories == totalStories, String(format:"totalStories property was not set properly. Was set to: %@ rather than: %@", character!.totalStories!, totalStories!));
    }
    
    func test_parseCharacter_totalEvents() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.totalEvents == totalEvents, String(format:"totalEvents property was not set properly. Was set to: %@ rather than: %@", character!.totalEvents!, totalEvents!));
    }
    
    func test_parseCharacter_detailURL() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.detailURL == detailURL, String(format:"detailURL property was not set properly. Was set to: %@ rather than: %@", character!.detailURL!, detailURL!));
    }
    
    func test_parseCharacter_wikiURL() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.wikiURL == wikiURL, String(format:"wikiURL property was not set properly. Was set to: %@ rather than: %@", character!.wikiURL!, wikiURL!));
    }
    
    func test_parseCharacter_comicLinkURL() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.comicLinkURL == comicLinkURL, String(format:"comicLinkURL property was not set properly. Was set to: %@ rather than: %@", character!.comicLinkURL!, comicLinkURL!));
    }
    
    func test_parseCharacter_thumbnailPath() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.thumbnailPath == thumbnailPath, String(format:"thumbnailPath property was not set properly. Was set to: %@ rather than: %@", character!.thumbnailPath!, thumbnailPath!));
    }
    
    func test_parseCharacter_thumbnailExtension() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        XCTAssertTrue(character!.thumbnailExtension == thumbnailExtension, String(format:"thumbnailExtension property was not set properly. Was set to: %@ rather than: %@", character!.thumbnailExtension!, thumbnailExtension!));
    }
    
    func test_parseCharacter_modified() {
        
        let character = parser?.parseCharacter(characterJSON!)
        
        let dateFormatter: NSDateFormatter = NSDateFormatter.serverDateFormatter()
        
        let dateFormated = dateFormatter.dateFromString(modified!)
        
        XCTAssertTrue(character!.modified == dateFormated!, String(format:"modified property was not set properly. Was set to: %@ rather than: %@", character!.modified!, dateFormated!));
    }
    
    
    // MARK: - CharactersParser

}
