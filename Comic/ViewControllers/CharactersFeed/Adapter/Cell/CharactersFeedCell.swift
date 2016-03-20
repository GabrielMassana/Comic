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

    private var nameLabel: UILabel = {
        
        let nameLabel: UILabel = UILabel.newAutoLayoutView()
        
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.textAlignment = .Left
        
        return nameLabel
    }()
    
    private var descriptionLabel: UILabel = {
        
        let descriptionLabel: UILabel = UILabel.newAutoLayoutView()
        
        descriptionLabel.backgroundColor = UIColor.whiteColor()
        descriptionLabel.textAlignment = .Left
        descriptionLabel.text = "No descripton avalaible"
        descriptionLabel.numberOfLines = 4
        
        return descriptionLabel
    }()
    
    var characterImageView: UIImageView = {
        
        let characterImageView: UIImageView = UIImageView.newAutoLayoutView()
        
        return characterImageView
    }()
    
    private var separationLine: UIView = {
    
        let separationLine = UIView.newAutoLayoutView()
        
        separationLine.backgroundColor = UIColor.altoColor()
        
        return separationLine
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCellStyle,reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func configureWithCharacter(character: Character) {
        
        nameLabel.text = character.name
        
        if let characterDescription = character.characterDescription {
            
            if characterDescription.characters.count > 0 {
                
                descriptionLabel.text = character.characterDescription
            }
        }
    }
    
    //MARK: - PrepareForReuse

    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        nameLabel.text = nil
        descriptionLabel.text = "No descripton avalaible"
//        characterImageView.image = Placeholder
    }
}
