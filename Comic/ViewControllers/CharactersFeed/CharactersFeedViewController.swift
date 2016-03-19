//
//  CharactersFeedViewController.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharactersFeedViewController: UIViewController {

    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        
        // API call to download Characters
        CharactersAPIManager.retrieveCharacters(
            { (result) -> Void in
                
            
            })
            { (error) -> Void in
                
        }
    }
}
