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

    /**
    Stores a bit to know if the Search bar is visible or not.
    */
    var isSearchBarVisible: Bool = false
    
    /**
     CharacterDetailViewController optional instance.
     */
    var characterDetail: CharacterDetailViewController?
    
    /**
     Empty View to be shown when no data in the Table View.
     */
    lazy var emptyView: CharactersFeedEmptyView = {
        
        let emptyView: CharactersFeedEmptyView = CharactersFeedEmptyView(frame: CGRect.init(x: 0.0, y: 0.0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds) - NavigationBarHeight))
        
        return emptyView
    }()
    
    /**
     Table view to display data.
     */
    lazy var tableView: UITableView = {
       
        let tableView: ComicTableView = ComicTableView.newAutoLayoutView()
        
        tableView.emptyView = self.emptyView
        
        return tableView
    }()
    
    /**
     Adapter to  manage the common logic of the tableView.
     */
    lazy var adapter: CharactersFeedAdapter = {
        
        let adapter = CharactersFeedAdapter()
        
        adapter.delegate = self
        
        return adapter
    }()
    
    /**
     NavigationItem titleView view.
     */
    var titleViewLabel: UILabel = {
       
        let titleViewLabel: UILabel = UILabel(frame: CGRect.init(x: 0.0, y: 0.0, width: 200.0, height: 25.0))
        
        titleViewLabel.text = NSLocalizedString("Characters", comment: "")
        titleViewLabel.textAlignment = .Center
        titleViewLabel.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        titleViewLabel.adjustsFontSizeToFitWidth = true
        titleViewLabel.minimumScaleFactor = 0.5
        
        return titleViewLabel
    }()
    
    /**
     Search button item to be placed on the NavigationItem.
     */
    lazy var searchButton: UIBarButtonItem = {
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Search", comment: ""), style: .Plain, target: self, action: "searchButtonPressed:")
        
        searchButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont.tradeGothicLTWithSize(15.0),
            NSForegroundColorAttributeName : UIColor.blackColor()],
            forState: UIControlState.Normal)
        
        return searchButton
    }()
    
    /**
     Text Field acting as search bar to filter the data in the table view.
     */
    lazy var searchTextField: SearchTextField = {
        
        let searchTextField: SearchTextField = SearchTextField.newAutoLayoutView()
        
        searchTextField.font = UIFont.tradeGothicLTWithSize(15.0)
        searchTextField.delegate = self
        searchTextField.returnKeyType = .Search
        searchTextField.tintColor = UIColor.blackColor()
        
        let attributes = [NSForegroundColorAttributeName: UIColor.scorpionColor(),
            NSFontAttributeName : UIFont.tradeGothicLTWithSize(15.0)]
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Character name", comment: ""), attributes:attributes)
        
        return searchTextField
    }()
    
    /**
     Constraint to update the searchTextField position.
     */
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

    /**
    Search Button Action.
    
    - parameter sender: UIButton triggering the action.
    */
    func searchButtonPressed(sender: UIBarButtonItem) {
        
        updateSearchTextFieldVisibility(true, duration: 0.3)
    }
    
    //MARK: - RetrieveData

    /**
    Triggers the actions to download and parse characters data from the APi with an offset
    
    - parameter offset: the offset of data to be ask for.
    */
    private func downloadDataFromMarvelAPI(offset: Int) {
        
        // API call to download Characters
        
        CharactersAPIManager.retrieveCharacters(String(offset),
            success: { [weak self] (result) -> Void in
                
                if let strongSelf = self {
                    
                    strongSelf.paginate()
                }
            },
            failure: { (error) -> Void in
        })
    }
    
    /**
     Calls for a next page of data from the Marvel API if there are more content to be downloaded.
     */
    private func paginate() {
        
         CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.performBlockAndWait { () -> Void in
            
            let feed: CharacterFeed = CharacterFeed.fetchCharactersFeed(CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext)
            
            if feed.hasMoreContentToDownload() {
                
                self.downloadDataFromMarvelAPI((feed.characters?.count)!)
            }
        }
    }
    
    //MARK: - SearchTextField
    
    /**
     Updates searchTextField object visibility with an animation.
    
     - parameter visible: True if should be visible. False otherwise.
     - parameter duration: the duration of the animation
     */
    func updateSearchTextFieldVisibility(visible: Bool, duration: NSTimeInterval) {
        
        var top: CGFloat = NavigationBarHeight
        var y: CGFloat = -NavigationBarHeight
        
        if visible {
            
            top = NavigationBarHeight + SearchBarHeight
            y = -(NavigationBarHeight + SearchBarHeight)
            
            searchTextField.becomeFirstResponder()
            view.layoutIfNeeded()
            
            searchTextFieldTopConstraint?.constant = NavigationBarHeight
            
            self.tableView.contentInset = UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0)
            self.tableView.contentOffset = CGPoint.init(x: 0.0, y: y)
        }
        else
        {
            searchTextField.resignFirstResponder()
            view.layoutIfNeeded()
            
            searchTextFieldTopConstraint?.constant = 0.0
        }
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            self.tableView.contentInset = UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0)
            self.tableView.contentOffset = CGPoint.init(x: 0.0, y: y)
            
            self.view.layoutIfNeeded()
            })
            { (Bool) -> Void in
                
                if visible {
                    
                    self.isSearchBarVisible = true
                }
                else
                {
                    self.isSearchBarVisible = false
                }
        }
    }
    
    /**
     Calls the adapter to filter the table view with a given search criteria String.
     
     - parameter searchCriteria: search criteria to filter the data.
     */
    func filterTableViewWithSearchCriteria(searchCriteria: String) {
        
        adapter.filterTableViewWithSearchCriteria(searchCriteria)
    }
    
    /**
     Updates titleViewLabel object with a given search criteria String.
     
     - parameter searchCriteria: search criteria to filter the data.
     */
    func updateTitleViewLabel(searchCriteria: String) {
        
        if searchCriteria.characters.count > 0 {
            
            titleViewLabel.text = String(format: "%@ %@", NSLocalizedString("Name Contains:", comment: ""), searchCriteria)
        }
        else
        {
            titleViewLabel.text = NSLocalizedString("Characters", comment: "")
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        updateSearchTextFieldVisibility(false, duration: 0.3)
        
        if let _ = textField.text {
            
            filterTableViewWithSearchCriteria(textField.text!)
            updateTitleViewLabel(textField.text!)
        }
        
        textField.text? = ""
        
        return true
    }
    
    //MARK: - CharactersFeedAdapterDelegate
    
    func didSelectCharacter(character: Character) {
    
        characterDetail = CharacterDetailViewController(character: character)
        
        self.navigationController?.pushViewController(characterDetail!, animated: true)
    }
    
    func scrollViewDidScroll() {
        
        if isSearchBarVisible {
            
            updateSearchTextFieldVisibility(false, duration: 0.1)
        }
    }

}
