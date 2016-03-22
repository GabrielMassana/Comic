//
//  CharacterDetailViewController.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    //MARK: - Accessors
    
    var character: Character?
    
    /**
     NavigationItem titleView view.
     */
    lazy var titleViewLabel: UILabel = {
        
        let titleViewLabel: UILabel = UILabel(frame: CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 25.0))
        
        titleViewLabel.text = NSLocalizedString("Character Details", comment: "")
        titleViewLabel.textAlignment = .Center
        titleViewLabel.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        
        return titleViewLabel
    }()
    
    /**
     Back button item to be placed on the NavigationItem.
     */
    lazy var backButton: UIBarButtonItem = {
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("❮ Back", comment: "") , style: .Plain, target: self, action: "backButtonPressed:")
        
        backButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont.tradeGothicLTWithSize(15.0),
            NSForegroundColorAttributeName : UIColor.blackColor()],
            forState: UIControlState.Normal)
        
        return backButton
    }()
    
    /**
     Image View with the character image.
     */
    lazy var characterImageView: UIImageView = {
        
        let characterImageView: UIImageView = UIImageView.newAutoLayoutView()
        
        characterImageView.image = UIImage(named: "icon-detail-placeholder")
        
        MediaAPIManager.retrieveMediaAsset(MediaAspectRatio.Landscape, character: self.character!) { (imageCharacter: Character, mediaImage: UIImage?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                characterImageView.image = mediaImage
            })
        }
        
        return characterImageView
    }()
    
    /**
     Label with the Character name.
     */
    lazy var nameLabel: UILabel = {
        
        let nameLabel: UILabel = UILabel.newAutoLayoutView()
        
        nameLabel.backgroundColor = UIColor.whiteColor()
        nameLabel.textAlignment = .Left
        nameLabel.font = UIFont.tradeGothicNo2BoldWithSize(30.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        
        if let _ = self.character {
            
            nameLabel.text = self.character!.name
        }
        
        return nameLabel
    }()
    
    /**
     Label with the Character description.
     */
    lazy var descriptionLabel: UILabel = {
        
        let descriptionLabel: UILabel = UILabel.newAutoLayoutView()
        
        descriptionLabel.backgroundColor = UIColor.whiteColor()
        descriptionLabel.textAlignment = .Left
        descriptionLabel.text = NSLocalizedString("No descripton avalaible", comment: "")
        descriptionLabel.numberOfLines = 6
        descriptionLabel.font = UIFont.tradeGothicLTWithSize(13.0)
        descriptionLabel.textColor = UIColor.scorpionColor()
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        
        if let _ = self.character {
            
            if let characterDescription = self.character!.characterDescription {
                
                if characterDescription.characters.count > 0 {
                    
                    descriptionLabel.text = self.character!.characterDescription
                }
            }
        }
        
        return descriptionLabel
    }()
    
    /**
     Separation line between data.
     */
    private var separationLine: UIView = {
        
        let separationLine = UIView.newAutoLayoutView()
        
        separationLine.backgroundColor = UIColor.altoColor()
        
        return separationLine
    }()
    
    /**
     Label with the Character total comics data.
     */
    lazy var totalComicsLabel: UILabel = {
        
        let totalComicsLabel: UILabel = UILabel.newAutoLayoutView()
        
        totalComicsLabel.textAlignment = .Left
        totalComicsLabel.font = UIFont.tradeGothicLTWithSize(17.0)
        totalComicsLabel.textColor = UIColor.scorpionColor()
        totalComicsLabel.text = String(format: "%@ %@", NSLocalizedString("Total Comics:", comment: ""), "0")
        
        if let _ = self.character {
            
            if let totalComics = self.character!.totalComics {

                totalComicsLabel.text =  String(format: "%@ %@", NSLocalizedString("Total Comics:", comment: ""), self.character!.totalComics!)
            }
        }
        
        return totalComicsLabel
    }()
    
    /**
     Label with the Character total series data.
     */
    lazy var totalSeriesLabel: UILabel = {
        
        let totalSeriesLabel: UILabel = UILabel.newAutoLayoutView()
        
        totalSeriesLabel.textAlignment = .Left
        totalSeriesLabel.font = UIFont.tradeGothicLTWithSize(17.0)
        totalSeriesLabel.textColor = UIColor.scorpionColor()
        totalSeriesLabel.text = String(format: "%@ %@", NSLocalizedString("Total Series:", comment: ""), "0")
        
        if let _ = self.character {
            
            if let totalSeries = self.character!.totalSeries {
                
                totalSeriesLabel.text =  String(format: "%@ %@", NSLocalizedString("Total Series:", comment: ""), self.character!.totalSeries!)
            }
        }
        
        return totalSeriesLabel
    }()
    
    /**
     Label with the Character total stories data.
     */
    lazy var totalStoriesLabel: UILabel = {
        
        let totalStoriesLabel: UILabel = UILabel.newAutoLayoutView()
        
        totalStoriesLabel.textAlignment = .Right
        totalStoriesLabel.font = UIFont.tradeGothicLTWithSize(17.0)
        totalStoriesLabel.textColor = UIColor.scorpionColor()
        totalStoriesLabel.text = String(format: "%@ %@", NSLocalizedString("Total Stories:", comment: ""), "0")
        
        if let _ = self.character {
            
            if let totalStories = self.character!.totalStories {
                
                totalStoriesLabel.text =  String(format: "%@ %@", NSLocalizedString("Total Stories:", comment: ""), self.character!.totalStories!)
            }
        }
        
        return totalStoriesLabel
    }()
    
    /**
     Label with the Character total events data.
     */
    lazy var totalEventsLabel: UILabel = {
        
        let totalEventsLabel: UILabel = UILabel.newAutoLayoutView()
        
        totalEventsLabel.textAlignment = .Right
        totalEventsLabel.font = UIFont.tradeGothicLTWithSize(17.0)
        totalEventsLabel.textColor = UIColor.scorpionColor()
        totalEventsLabel.text = String(format: "%@ %@", NSLocalizedString("Total Events:", comment: ""), "0")
        
        if let _ = self.character {
            
            if let totalEvents = self.character!.totalEvents {
                
                totalEventsLabel.text =  String(format: "%@ %@", NSLocalizedString("Total Events:", comment: ""), self.character!.totalEvents!)
            }
        }
        
        return totalEventsLabel
    }()
    
    /**
     Button with the Character wiki link.
     */
    lazy var wikiButton: UIButton = {
        
        let wikiButton: UIButton = UIButton.newAutoLayoutView()
        
        wikiButton.titleLabel!.textAlignment = .Center
        wikiButton.titleLabel!.lineBreakMode = .ByWordWrapping
        wikiButton.titleLabel!.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        wikiButton.titleLabel!.textColor = UIColor.whiteColor()
        wikiButton.setTitle(NSLocalizedString("MARVEL\nWIKI", comment: ""), forState: .Normal)
        wikiButton.addTarget(self, action: "wikiButtonPresed:", forControlEvents: .TouchUpInside)
        
        wikiButton.bbc_backgroundColorNormal(UIColor.redRibbonColor(), backgroundColorHighlighted: UIColor.monarchColor())
        
        return wikiButton
    }()
    
    /**
     Button with the Character details link.
     */
    lazy var detailButton: UIButton = {
        
        let detailButton: UIButton = UIButton.newAutoLayoutView()
        
        detailButton.titleLabel!.textAlignment = .Center
        detailButton.titleLabel!.lineBreakMode = .ByWordWrapping
        detailButton.titleLabel!.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        detailButton.titleLabel!.textColor = UIColor.whiteColor()
        detailButton.setTitle(NSLocalizedString("MORE\nINFO", comment: ""), forState: .Normal)
        detailButton.addTarget(self, action: "detailButtonPresed:", forControlEvents: .TouchUpInside)
        
        detailButton.bbc_backgroundColorNormal(UIColor.coniferColor(), backgroundColorHighlighted: UIColor.oliveDrabColor())
        
        return detailButton
    }()
    
    /**
     Button with the Character comic link.
     */
    lazy var comicButton: UIButton = {
        
        let comicButton: UIButton = UIButton.newAutoLayoutView()
        
        comicButton.titleLabel!.textAlignment = .Center
        comicButton.titleLabel!.lineBreakMode = .ByWordWrapping
        comicButton.titleLabel!.font = UIFont.tradeGothicNo2BoldWithSize(20.0)
        comicButton.titleLabel!.textColor = UIColor.whiteColor()
        comicButton.setTitle(NSLocalizedString("COMIC\nLINKS", comment: ""), forState: .Normal)
        comicButton.addTarget(self, action: "comicButtonPresed:", forControlEvents: .TouchUpInside)
        
        comicButton.bbc_backgroundColorNormal(UIColor.blueLagoonColor(), backgroundColorHighlighted: UIColor.daintreeLagoonColor())
        
        return comicButton
    }()
    
    //MARK: - Init
    
    init (character: Character) {
        
        self.character = character
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.titleView = titleViewLabel;
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder:aDecoder)
    }
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        /*-------------------*/
        
        self.view.addSubview(characterImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(separationLine)
        self.view.addSubview(totalComicsLabel)
        self.view.addSubview(totalSeriesLabel)
        self.view.addSubview(totalStoriesLabel)
        self.view.addSubview(totalEventsLabel)
        self.view.addSubview(wikiButton)
        self.view.addSubview(detailButton)
        self.view.addSubview(comicButton)

        handleButtonVisibility()
        
        /*-------------------*/

        updateViewConstraints()
    }
    
    //MARK: - Constraints
    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        
        let buttonDimension: CGFloat = (CGRectGetWidth(UIScreen.mainScreen().bounds) - (40.0 * DeviceSizeService.sharedInstance.resizeFactor)) / 3.0
        
        /*-------------------*/
        
        characterImageView.autoPinEdgeToSuperviewEdge(.Left)
        characterImageView.autoPinEdgeToSuperviewEdge(.Right)
        characterImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: NavigationBarHeight)
        characterImageView.autoSetDimension(.Height, toSize: (CGRectGetWidth(UIScreen.mainScreen().bounds) * 261.0) / 464.0)
        
        /*-------------------*/
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        nameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: characterImageView, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        descriptionLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        descriptionLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        descriptionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: 4.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        separationLine.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoPinEdge(.Top, toEdge: .Bottom, ofView: descriptionLabel, withOffset: 5.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        separationLine.autoSetDimension(.Height, toSize: 0.5 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        totalComicsLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalComicsLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalComicsLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: separationLine, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        totalSeriesLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalSeriesLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalSeriesLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: totalComicsLabel, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        totalStoriesLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalStoriesLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalStoriesLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: separationLine, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        totalEventsLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalEventsLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        totalEventsLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: totalComicsLabel, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        
        /*-------------------*/
        
        wikiButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        wikiButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        wikiButton.autoSetDimensionsToSize(CGSize.init(width: buttonDimension, height: buttonDimension))
        
        /*-------------------*/
        
        detailButton.autoPinEdge(.Left, toEdge: .Right, ofView: wikiButton, withOffset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        detailButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        detailButton.autoSetDimensionsToSize(CGSize.init(width: buttonDimension, height: buttonDimension))
        
        /*-------------------*/
        
        comicButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        comicButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10.0 * DeviceSizeService.sharedInstance.resizeFactor)
        comicButton.autoSetDimensionsToSize(CGSize.init(width: buttonDimension, height: buttonDimension))
    }
    
    //MARK: - ButtonVisibility
    
    /**
     Function to handle link buttons visibility and interaction.
     */
    func handleButtonVisibility() {
        
        if let _ = self.character {
            
            if let wikiURL = self.character!.wikiURL {
                
                if wikiURL.characters.count == 0 {
                    
                    wikiButton.alpha = 0.3
                    wikiButton.userInteractionEnabled = false
                }
            }
            
            if let comicLinkURL = self.character!.comicLinkURL {
                
                if comicLinkURL.characters.count == 0 {
                    
                    comicButton.alpha = 0.3
                    comicButton.userInteractionEnabled = false
                }
            }
            
            if let detailURL = self.character!.detailURL {
                
                if detailURL.characters.count == 0 {
                    
                    detailButton.alpha = 0.3
                    comicButton.userInteractionEnabled = false
                }
            }
        }
    }
    
    //MARK: - ButtonActions
    
    /**
     Back Button Action.
    
     - parameter sender: UIButton triggering the action.
     */
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     Wiki Button Action. Action opens Safari navigator.
     
     - parameter sender: UIButton triggering the action.
     */
    func wikiButtonPresed(sender: UIBarButtonItem) {
        
        if let _ = self.character {
            
            if let wikiURL = self.character!.wikiURL {
                
                if let requestUrl = NSURL(string: wikiURL) {
                    
                    UIApplication.sharedApplication().openURL(requestUrl)
                }
            }
        }
    }

    /**
     Detail Button Action. Action opens Safari navigator.
     
     - parameter sender: UIButton triggering the action.
     */
    func detailButtonPresed(sender: UIBarButtonItem) {
        
        if let _ = self.character {
            
            if let detailURL = self.character!.detailURL {
                
                if let requestUrl = NSURL(string: detailURL) {
                    
                    UIApplication.sharedApplication().openURL(requestUrl)
                }
            }
        }
    }
    
    /**
     ComicLink Button Action. Action opens Safari navigator.
     
     - parameter sender: UIButton triggering the action.
     */
    func comicButtonPresed(sender: UIBarButtonItem) {
        
        if let _ = self.character {
            
            if let comicLinkURL = self.character!.comicLinkURL {
                
                if let requestUrl = NSURL(string: comicLinkURL) {
                    
                    UIApplication.sharedApplication().openURL(requestUrl)
                }
            }
        }
    }
}
