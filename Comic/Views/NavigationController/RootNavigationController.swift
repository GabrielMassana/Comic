//
//  RootNavigationController.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    //MARK: - Accessors

    var rootViewController: CharactersFeedViewController = {
        
        let charactersFeed: CharactersFeedViewController = CharactersFeedViewController()
        
        return charactersFeed
    }()
    
    //MARK: - Init

    init() {
        
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nil, bundle: nil)
    }
}
