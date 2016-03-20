//
//  CharactersFeedCell.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharactersFeedCell: TableViewCell {

    
    //MARK: - Configure
    
    func configureWithCharacter(character: Character) {
        
        if Int(character.characterID!)! % 2 == 0 {
            
            backgroundColor = UIColor.greenColor()
        }
        
        textLabel?.text = character.name
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        textLabel?.text = nil
        backgroundColor = UIColor.whiteColor()

    }
}
