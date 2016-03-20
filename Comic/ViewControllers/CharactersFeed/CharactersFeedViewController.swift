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

let NavigationBarHeight: CGFloat = 64.0
let SearchBarHeight: CGFloat = 56.0

class CharactersFeedViewController: UIViewController, CharactersFeedAdapterDelegate, UITextFieldDelegate {

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
    
    var titleViewLabel: UILabel = {
       
        let titleViewLabel: UILabel = UILabel(frame: CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 20.0))
        titleViewLabel.text = "Characters"
        titleViewLabel.textAlignment = .Center
        titleViewLabel.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        
        return titleViewLabel
    }()
    
    lazy var searchButton: UIBarButtonItem = {
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "searchButtonPressed:")
        
        searchButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont.tradeGothicLTWithSize(15.0),
            NSForegroundColorAttributeName : UIColor.blackColor()],
            forState: UIControlState.Normal)
        
        return searchButton
    }()
    
    lazy var searchTextField: SearchTextField = {
        
        let searchTextField: SearchTextField = SearchTextField.newAutoLayoutView()
        
        searchTextField.font = UIFont.tradeGothicLTWithSize(15.0)
        searchTextField.delegate = self
        searchTextField.returnKeyType = .Search
        searchTextField.tintColor = UIColor.blackColor()
        
        let attributes = [NSForegroundColorAttributeName: UIColor.scorpionColor(),
            NSFontAttributeName : UIFont.tradeGothicLTWithSize(15.0)]
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Character name", attributes:attributes)
        
        return searchTextField
    }()
    
    var searchTextFieldTopConstraint: NSLayoutConstraint?
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        /*-------------------*/

        view.addSubview(tableView)
        view.addSubview(searchTextField)
        navigationItem.leftBarButtonItem = searchButton
            
        adapter.tableView = tableView
        
        /*-------------------*/

        paginate()
        
        /*-------------------*/
        
        updateViewConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationItem.titleView = titleViewLabel;
    }
    
    //MARK: - Constraints
    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        
        /*-------------------*/
        
        tableView.autoPinEdgesToSuperviewEdges()
        
        /*-------------------*/

        if searchTextFieldTopConstraint == nil {
            
            searchTextFieldTopConstraint = searchTextField.autoPinEdgeToSuperviewEdge(.Top, withInset: 0.0) as NSLayoutConstraint
        }
        
        searchTextField.autoPinEdgeToSuperviewEdge(.Left)
        searchTextField.autoPinEdgeToSuperviewEdge(.Right)
        searchTextField.autoSetDimension(.Height, toSize: SearchBarHeight)
    }
    
    //MARK: - ButtonActions

    func searchButtonPressed(sender: UIBarButtonItem) {
        
        updateSearchTextFieldVisibility(true)
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
    
    //MARK: - SearchTextField
    
    func updateSearchTextFieldVisibility(visible: Bool) {
        
        var top: CGFloat = NavigationBarHeight
        var y: CGFloat = -NavigationBarHeight
        
        if visible {
            
            top = NavigationBarHeight  + SearchBarHeight
            y = -(NavigationBarHeight + SearchBarHeight)
            
            searchTextField.becomeFirstResponder()
            view.layoutIfNeeded()
            
            searchTextFieldTopConstraint?.constant = NavigationBarHeight
        }
        else
        {
            searchTextField.resignFirstResponder()
            view.layoutIfNeeded()
            
            searchTextFieldTopConstraint?.constant = 0.0
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.tableView.contentInset = UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0)
            self.tableView.contentOffset = CGPoint.init(x: 0.0, y: y)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func filterTableViewWithSearchCriteria(searchCriteria: String) {
        
        adapter.filterTableViewWithSearchCriteria(searchCriteria)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        updateSearchTextFieldVisibility(false)
        
        if let _ = textField.text {
            
            filterTableViewWithSearchCriteria(textField.text!)
        }
        
        textField.text? = ""
        
        return true
    }
}
