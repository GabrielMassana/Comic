//
//  CharactersFeedEmptyView.swift
//  Comic
//
//  Created by Gabriel Massana on 21/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharactersFeedEmptyView: UIView {

    //MARK: - Accessors
    
    var titleLabel: UILabel = {
       
        let titleLabel: UILabel = UILabel.newAutoLayoutView()
        
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.tradeGothicNo2BoldWithSize(20)
        titleLabel.textColor = UIColor.scorpionColor()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .Center
        var attributedText = NSMutableAttributedString(string: NSLocalizedString("🙈 Wops!\nNothing to be shown here!\nSorry! 😇", comment: ""))
        attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
        
        titleLabel.attributedText = attributedText
        
        return titleLabel
    }()
    
    //MARK - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    
    //MARK - Constraints
    
    override func updateConstraints() {
        
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 200.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        super.updateConstraints()
    }
}
