//
//  CharactersFeedCell.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharactersFeedCell: TableViewCell {

    //MARK: - Accessors

    var character: Character?
    
    /**
     Label with the Character name.
     */
    private var nameLabel: UILabel = {
        
        let nameLabel: UILabel = UILabel.newAutoLayoutView()
        
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.textAlignment = .Left
        nameLabel.font = UIFont.tradeGothicNo2BoldWithSize(17.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        
        return nameLabel
    }()
    
    /**
     Label with the Character description.
     */
    private var descriptionLabel: UILabel = {
        
        let descriptionLabel: UILabel = UILabel.newAutoLayoutView()
        
        descriptionLabel.backgroundColor = UIColor.whiteColor()
        descriptionLabel.textAlignment = .Left
        descriptionLabel.text = NSLocalizedString("No descripton avalaible", comment: "")
        descriptionLabel.numberOfLines = 5
        descriptionLabel.font = UIFont.tradeGothicLTWithSize(10.0)
        descriptionLabel.textColor = UIColor.scorpionColor()
        
        return descriptionLabel
    }()
    
    /**
     Image View with the character image.
     */
    var characterImageView: UIImageView = {
        
        let characterImageView: UIImageView = UIImageView.newAutoLayoutView()
        
        characterImageView.image = UIImage(named: "icon-cell-placeholder")
        characterImageView.layer.borderWidth = 0.0;
        characterImageView.layer.cornerRadius = 14.0 * DeviceSizeService.sharedInstance.resizeFactor;
        
        return characterImageView
    }()
    
    /**
     Separation line between cells.
     */
    private var separationLine: UIView = {
    
        let separationLine = UIView.newAutoLayoutView()
        
        separationLine.backgroundColor = UIColor.altoColor()
        
        return separationLine
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCellStyle,reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(characterImageView)
        contentView.addSubview(separationLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        
        characterImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        characterImageView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        characterImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        characterImageView.autoSetDimension(.Width, toSize: 100.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/

        nameLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: characterImageView, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        nameLabel.autoSetDimension(.Height, toSize: 30.0 * DeviceSizeService.sharedInstance.resizeFactor)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)

        /*-------------------*/

        descriptionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: 5.0 * DeviceSizeService.sharedInstance.resizeFactor)
        descriptionLabel.autoPinEdge(.Left, toEdge: .Right, ofView: characterImageView, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        descriptionLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)

        /*-------------------*/
        
        separationLine.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoPinEdgeToSuperviewEdge(.Bottom)
        separationLine.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoSetDimension(.Height, toSize: 0.5 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/

        super.updateConstraints()
    }
    
    //MARK: - Configure
    
    /**
    Configures the cell with a given Character object.
    
    - parameter character: the character to be shown in the cell.
    */
    func configureWithCharacter(character: Character) {
        
        self.character = character
        
        nameLabel.text = character.name        
        
        if let characterDescription = character.characterDescription {
            
            if characterDescription.characters.count > 0 {
                
                descriptionLabel.text = character.characterDescription
            }
        }
        
        MediaAPIManager.retrieveMediaAsset(MediaAspectRatio.Square, character: character) { [weak self] (imageCharacter: Character, mediaImage: UIImage?) -> Void in
            
            if let strongSelf = self {
                
                if strongSelf.character!.characterID == imageCharacter.characterID {
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        strongSelf.characterImageView.image = mediaImage
                    })
                }
            }
        }
    }
    
    //MARK: - PrepareForReuse

    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        nameLabel.text = nil
        descriptionLabel.text = NSLocalizedString("No descripton avalaible", comment: "")
        characterImageView.image = UIImage(named: "icon-cell-placeholder")
        character = nil
    }
}
