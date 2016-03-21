//
//  CharactersFeedParserTests.swift
//  Comic
//
//  Created by GabrielMassana on 21/03/2016.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import XCTest

@testable import Comic

import CoreDataFullStack

class CharactersFeedParserTests: XCTestCase, CDFCoreDataManagerDelegate {

    //MARK: - Accessors

    var parser: CharactersFeedParser?
    
    var feedJSON: NSDictionary?
    var dataJSON: NSDictionary?
    var feedServerErrorJSON: NSDictionary?
    var charactersJSON: NSArray?

    var totalCharacters: NSNumber?
    
    //MARK: - CDFCoreDataManagerDelegate
    
    internal func coreDataModelName() -> String! {
        
        return "Marvel"
    }
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        
        super.setUp()
        
        CDFCoreDataManager.sharedInstance().delegate = self
        
        parser = CharactersFeedParser(managedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext)
        
        totalCharacters = NSNumber(int: 1485)
        
        charactersJSON = [
                [
                "id": 123456,
                "name": "Some name",
                "description": "some",
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
                        "url": "http://marvel.com/characters/9/captain_marvel?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
                    ],
                    [
                        "type": "comiclink",
                        "url": "http://marvel.com/characters/9/captain_marvel?utm_campaign=apiRef&utm_source=6c3ee59b795443c3ec99cd142c50e639"
                    ]
                ]
            ]
        ]
        
        dataJSON = [
            "total": totalCharacters!,
            "results": charactersJSON!
        ]
        
        
        feedJSON = [
            "data": dataJSON!
        ]
        
        feedServerErrorJSON = NSDictionary()
    }
    
    override func tearDown() {
        
        CDFCoreDataManager.sharedInstance().reset()
        
        parser = nil
        
        feedJSON = nil
        dataJSON = nil
        feedServerErrorJSON = nil
        charactersJSON = nil
        
        totalCharacters = nil
        
        super.tearDown()
    }
    
    // MARK: - Feed
    
    func test_parseFeed_newCharacterObjectReturned() {
        
        let feed = parser?.parseFeed(feedJSON!)
        
        XCTAssertNotNil(feed, "A valid Character object wasn't created");
    }
    
    func test_parseFeed_total() {
        
        let feed = parser?.parseFeed(feedJSON!)
        
        XCTAssertTrue(feed!.totalCharacters == totalCharacters, String(format:"totalCharacters property was not set properly. Was set to: %@ rather than: %@", feed!.totalCharacters!, totalCharacters!));
    }
    
    func test_parseFeed_charactersCount() {
        
        let feed = parser?.parseFeed(feedServerErrorJSON!)
        
        XCTAssertNotNil(feed!.lastServerFailure, "lastServerFailure property was not set.");
    }
}
