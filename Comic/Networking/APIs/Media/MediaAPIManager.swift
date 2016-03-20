//
//  MediaAPIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking

enum MediaAspectRatio: String {
    
    case Square = "standard_xlarge"
    case Landscape = "landscape_incredible"
}

class MediaAPIManager: NSObject {

    class func retrieveMediaAsset(mediaAspectRatio: MediaAspectRatio, character: Character, completion:((imageCharacter: Character, mediaImage: UIImage?) -> Void)?) {
    
        let documentsDirectory: String = NSFileManager.cfm_documentsDirectoryPath()
        let absolutePath: String = documentsDirectory.stringByAppendingString(String(format: "/%@_%@", character.characterID!, mediaAspectRatio.rawValue))
        
        NSFileManager.cfm_fileExistsAtPath(absolutePath) { (fileExists: Bool) -> Void in
            
            if fileExists {
                
                let documentName: String = String(format: "%@_%@", character.characterID!, mediaAspectRatio.rawValue)
                
                let imageData = NSFileManager.cfm_retrieveDataFromDocumentsDirectoryWithPath(documentName)
                
                if var _ = imageData {
                    
                    let image: UIImage = UIImage(data: imageData)!
                    
                    if let _ = completion {
                        
                        completion!(imageCharacter: character, mediaImage: image)
                    }
                }
                else
                {
                    if let _ = completion {
                        
                        completion!(imageCharacter: character, mediaImage: nil)
                    }
                }
            }
            else
            {
                if let thumbnailPath = character.thumbnailPath {
                    
                    if let thumbnailExtension = character.thumbnailExtension {
                        
                        let urlString: String = String(format: "%@/%@.%@", thumbnailPath, mediaAspectRatio.rawValue, thumbnailExtension)

                        //TODO create request
                        let request: Request = Request.requestForAPI()
                        request.URL = NSURL(string: urlString)
                        
                        let task: CNMURLSessionDataTask = CNMSession.defaultSession().dataTaskFromRequest(request)
                        
                        task.onCompletion = { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                            
                            if (data != nil) {
                                
                                let image: UIImage = UIImage(data: data!)!

                                if let _ = completion {
                                    
                                    completion!(imageCharacter: character, mediaImage: image)
                                }
                                
                                let documentName: String = String(format: "%@_%@", character.characterID!, mediaAspectRatio.rawValue)

                                NSFileManager.cfm_saveData(data, toDocumentsDirectoryPath: documentName)
                            }
                            else
                            {
                                if let _ = completion {
                                    
                                    completion!(imageCharacter: character, mediaImage: nil)
                                }
                            }
                        }
                        
                        task.resume()
                    }
                }
            }
        }
    }
}
