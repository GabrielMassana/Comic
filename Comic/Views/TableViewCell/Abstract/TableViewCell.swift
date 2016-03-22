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
    
    /**
     Help class function to return the cell reuseIdentifier.
     */
    class func reuseIdentifier() -> String {
        
        return NSStringFromClass(self.self)
    }
    
    //MARK: - Layout
    
    /**  
     help function to call auto-layout methods.
     */
    func layoutByApplyingConstraints() {
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
