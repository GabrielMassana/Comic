//
//  CharactersFeedEmptyView.swift
//  Comic
//
//  Created by Gabriel Massana on 21/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharactersFeedEmptyView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orangeColor()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
}

