//
//  TableViewCell.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - Identifier
    
    class func reuseIdentifier() -> String {
        
        return NSStringFromClass(self.self)
    }
    
    //MARK: - Layout
    
    func layoutByApplyingConstraints() {
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
