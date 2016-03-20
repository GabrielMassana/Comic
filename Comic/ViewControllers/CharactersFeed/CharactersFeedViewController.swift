//
//  CharactersFeedViewController.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack
import PureLayout

class CharactersFeedViewController: UIViewController, CharactersFeedAdapterDelegate {

    //MARK: - Accessors

//    let characterDetail: CharacterDetailViewController!
    
    var tableView: UITableView = {
       
        let tableView: UITableView = UITableView.newAutoLayoutView()
        
        return tableView
    }()
    
    lazy var adapter: CharactersFeedAdapter = {
        
        let adapter = CharactersFeedAdapter()
        
        adapter.delegate = self
        
        return adapter
    }()
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        /*-------------------*/

        view.addSubview(tableView)
        adapter.tableView = tableView
        
        /*-------------------*/

        paginate()
        
        /*-------------------*/
        
        updateViewConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        
        /*-------------------*/
        
        tableView.autoPinEdgesToSuperviewEdges()
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
                
                if feed.characters?.count < 200 {
                
                    self.downloadDataFromMarvelAPI((feed.characters?.count)!)
                }
            }
        }
    }
}
