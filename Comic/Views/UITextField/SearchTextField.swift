//
//  SearchTextField.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    
    //MARK: - Accessors

    private var separationLine: UIView = {
        
        let separationLine = UIView.newAutoLayoutView()
        
        separationLine.backgroundColor = UIColor.altoColor()
        
        return separationLine
    }()
    
    //MARK - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(separationLine)
        contentVerticalAlignment = .Center
        autocorrectionType = .No
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //MARK - Constraints

    override func updateConstraints() {

        separationLine.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoPinEdgeToSuperviewEdge(.Bottom)
        separationLine.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoSetDimension(.Height, toSize: 0.5 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        super.updateConstraints()
    }
    
    //MARK - TextFieldTextOverridePosition

    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        
        let margin: CGFloat = 10.0 * DeviceSizeService.sharedInstance.resizeFactor
        
        var rect: CGRect?
        
        rect = CGRect.init(x: margin, y: 0.0, width: bounds.size.width - margin, height: bounds.size.height)
        
        if (CGRectIsNull(bounds) ||
            CGRectIsInfinite(bounds)) {
                
                rect = bounds
        }
        
        return rect!
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        
        let margin: CGFloat = 10.0 * DeviceSizeService.sharedInstance.resizeFactor
        
        var rect: CGRect?
        
        rect = CGRect.init(x: margin, y: 0.0, width: bounds.size.width - margin, height: bounds.size.height)
        
        if (CGRectIsNull(bounds) ||
            CGRectIsInfinite(bounds)) {
                
                rect = bounds
        }
        
        return rect!
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        
        let margin: CGFloat = 10.0 * DeviceSizeService.sharedInstance.resizeFactor
        
        var rect: CGRect?
        
        rect = CGRect.init(x: margin, y: 0.0, width: bounds.size.width - margin, height: bounds.size.height)
        
        if (CGRectIsNull(bounds) ||
            CGRectIsInfinite(bounds)) {
                
                rect = bounds
        }
        
        return rect!
    }
}
