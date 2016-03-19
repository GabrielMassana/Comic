//
//  CharactersFeedViewController.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack

class CharactersFeedViewController: UIViewController {

    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        /*-------------------*/

        paginate()
    }
    
    //MARK: - RetrieveData

    private func downloadDataFromMarvelAPI(offset: Int) {
        
        // API call to download Characters
        
        CharactersAPIManager.retrieveCharacters(String(offset),
            success: { (result) -> Void in
                
                self.paginate()
            },
            failure: { (error) -> Void in
        })
    }
    
    private func paginate() {
        
         CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.performBlockAndWait { () -> Void in
            
            let feed: CharacterFeed = CharacterFeed.fetchCharactersFeed(CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext)
            
            if feed.hasMoreContentToDownload() {
                
                // TODO uncomment. 
                // Doing it to do not waste API calls limit
//                self.downloadDataFromMarvelAPI((feed.characters?.count)!)
            }
        }
    }
}
