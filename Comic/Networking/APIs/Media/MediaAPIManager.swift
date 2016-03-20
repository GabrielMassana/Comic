//
//  MediaAPIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

let aspectRatio_square_standard_xlarge: String = "standard_xlarge"

class MediaAPIManager: NSObject {

    class func retrieveMediaAssetForCell(character: Character, completion:((character: Character, mediaImage: UIImage?) -> Void)?) {
    
        
        
        
        
        
        
        if let thumbnailPath = character.thumbnailPath {
            
            if let thumbnailExtension = character.thumbnailExtension {
                
                let urlString: String = String(format: "%@/%@.%@", thumbnailPath, aspectRatio_square_standard_xlarge, thumbnailExtension)
                
                print(urlString)
            }
        }

    }

}
