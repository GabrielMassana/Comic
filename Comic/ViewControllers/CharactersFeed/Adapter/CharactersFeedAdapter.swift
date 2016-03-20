//
//  CharactersFeedAdapter.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreDataFullStack

protocol CharactersFeedAdapterDelegate: class {
    
    func didSelectCharacter(character: Character)
}

class CharactersFeedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Accessors

    weak var delegate: CharactersFeedAdapterDelegate?

    var tableView: UITableView! {
        
        willSet (newValue) {
            
            if newValue != tableView {
                
                self.tableView = newValue
                
                tableView.dataSource = self
                tableView.delegate = self
                tableView.backgroundColor = UIColor.whiteColor()
                tableView.rowHeight = 120.0
                tableView.separatorStyle = .None
                
                //RegisterCells
                registerCells()
                
                do {
                    
                    try self.fetchedResultsController.performFetch()
                }
                catch
                {
                    
                }
            }
        }
    }
    
    lazy var fetchedResultsController: CDFTableViewFetchedResultsController =  {
        
        let fetchedResultsController = CDFTableViewFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.tableView = self.tableView
        
        return fetchedResultsController
    }()
    
    var fetchRequest: NSFetchRequest {
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(NSStringFromClass(Character.self), inManagedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext)
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetchRequest
    }
    
    lazy var sortDescriptors: Array<NSSortDescriptor> = {
        
        let sortDescriptors:NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        return [sortDescriptors]
    }()
    
    //MARK: - SearchTextField

    func filterTableViewWithSearchCriteria(searchCriteria: String) {
        
        if searchCriteria.characters.count > 0 {
            
            let predicate: NSPredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchCriteria)
            
            fetchedResultsController.fetchRequest.predicate = predicate
        }
        else
        {
            let predicate: NSPredicate = NSPredicate(format: "NOT (name CONTAINS[cd] %@)", searchCriteria)

            fetchedResultsController.fetchRequest.predicate = predicate
        }
        
        do {
            
            try self.fetchedResultsController.performFetch()
            tableView.reloadData()
        }
        catch
        {
            
        }
    }
    
    //MARK: - RegisterCells
    
    func registerCells() {
        
        tableView.registerClass(CharactersFeedCell.self, forCellReuseIdentifier: CharactersFeedCell.reuseIdentifier())
    }
    
    //MARK: - ConfigureCell
    
    func configureCell(cell:UITableViewCell, indexPath: NSIndexPath) {
        
        let character: Character = fetchedResultsController.fetchedObjects![indexPath.row] as! Character
        
        let cell = cell as! CharactersFeedCell
        
        cell.configureWithCharacter(character)
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let character: Character = fetchedResultsController.fetchedObjects![indexPath.row] as! Character

        self.delegate?.didSelectCharacter(character)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fetchedResultsController.fetchedObjects?.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CharactersFeedCell.reuseIdentifier(), forIndexPath: indexPath) as! CharactersFeedCell
        
        configureCell(cell, indexPath: indexPath)
        
        let character: Character = fetchedResultsController.fetchedObjects![indexPath.row] as! Character
        
        MediaAPIManager.retrieveMediaAsset(MediaAspectRatio.Square, character: character) { (imageCharacter: Character, mediaImage: UIImage?) -> Void in
            
            if character.characterID == imageCharacter.characterID {
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    cell.characterImageView.image = mediaImage
                })
            }
        }
        
        cell.layoutByApplyingConstraints()
        
        return cell
    }
}
