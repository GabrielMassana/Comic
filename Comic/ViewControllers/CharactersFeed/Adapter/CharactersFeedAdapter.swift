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
    
    func scrollViewDidScroll()
}

class CharactersFeedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Accessors

    /**
     Delegate object
     */
    weak var delegate: CharactersFeedAdapterDelegate?

    /**
     Search criteria to update the table view.
     */
    var searchCriteria: String = ""
    
    /**
     Table view to display data.
     */
    var tableView: UITableView! {
        
        willSet (newValue) {
            
            if newValue != tableView {
                
                self.tableView = newValue
                
                tableView.dataSource = self
                tableView.delegate = self
                tableView.backgroundColor = UIColor.whiteColor()
                tableView.rowHeight = 120.0 * DeviceSizeService.sharedInstance.resizeFactor
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
    
    /**
     Used to connect the TableView with Core Data.
     */
    lazy var fetchedResultsController: CDFTableViewFetchedResultsController =  {
        
        let fetchedResultsController = CDFTableViewFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.tableView = self.tableView
        
        return fetchedResultsController
    }()
    
    /**
     Fetch request for retrieving characters.
     */
    var fetchRequest: NSFetchRequest {
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(NSStringFromClass(Character.self), inManagedObjectContext: CDFCoreDataManager.sharedInstance().managedObjectContext)
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetchRequest
    }
    
    /**
     Sort Descriptors to sort how characters should be ordered.
     */
    lazy var sortDescriptors: Array<NSSortDescriptor> = {
        
        let sortDescriptors:NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        return [sortDescriptors]
    }()
    
    //MARK: - SearchTextField

    /**
     Updates fetchedResultsController object with a given search criteria
    
     - parameter searchCriteria: search criteria to filter the data.
     */
    func filterTableViewWithSearchCriteria(searchCriteria: String) {
        
        if self.searchCriteria.lowercaseString != searchCriteria.lowercaseString {
            
            self.searchCriteria = searchCriteria
            
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
    }
    
    //MARK: - RegisterCells
    
    /**
     Register the cells to be used in the table view.
     */
    func registerCells() {
        
        tableView.registerClass(CharactersFeedCell.self, forCellReuseIdentifier: CharactersFeedCell.reuseIdentifier())
    }
    
    //MARK: - ConfigureCell
    
    /**
     Configure the cell.
    
     - parameter cell: cell to be configured.
     - parameter indexPath: cell indexPath.
     */
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
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    
        self.delegate?.scrollViewDidScroll()
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fetchedResultsController.fetchedObjects?.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CharactersFeedCell.reuseIdentifier(), forIndexPath: indexPath) as! CharactersFeedCell
        
        configureCell(cell, indexPath: indexPath)

        cell.layoutByApplyingConstraints()
        
        return cell
    }
}
