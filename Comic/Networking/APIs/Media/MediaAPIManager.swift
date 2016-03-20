//
//  MediaAPIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 20/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking

let aspectRatio_square_standard_xlarge: String = "standard_xlarge"

class MediaAPIManager: NSObject {

    class func retrieveMediaAssetForCell(character: Character, completion:((character: Character, mediaImage: UIImage?) -> Void)?) {
    
        let documentsDirectory: String = NSFileManager.cfm_documentsDirectoryPath()
        let absolutePath: String = documentsDirectory.stringByAppendingString(String(format: "/%@", character.characterID!))
        
        NSFileManager.cfm_fileExistsAtPath(absolutePath) { (fileExists: Bool) -> Void in
            
            print(fileExists)
            
            if fileExists {
                
                let imageData = NSFileManager.cfm_retrieveDataFromDocumentsDirectoryWithPath(character.characterID!)
                
                if var _ = imageData {
                    
                    let image: UIImage = UIImage(data: imageData)!
                    
                    if let _ = completion {
                        
                        completion!(character: character, mediaImage: image)
                    }
                }
                else
                {
                    if let _ = completion {
                        
                        completion!(character: character, mediaImage: nil)
                        
                    }
                }
            }
            else
            {
                if let thumbnailPath = character.thumbnailPath {
                    
                    if let thumbnailExtension = character.thumbnailExtension {
                        
                        let urlString: String = String(format: "%@/%@.%@", thumbnailPath, aspectRatio_square_standard_xlarge, thumbnailExtension)
                        
                        print(urlString)
                        

                        let request: Request = Request.requestForAPI()
                        request.URL = NSURL(string: urlString)
                        
                        let task: CNMURLSessionDataTask = CNMSession.defaultSession().dataTaskFromRequest(request)

                        
                        task.onCompletion = { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                            
                            if (data != nil) {
                                
                                let image: UIImage = UIImage(data: data!)!

                                if let _ = completion {
                                    
                                    completion!(character: character, mediaImage: image)
                                }
                                
                                NSFileManager.cfm_saveData(data, toDocumentsDirectoryPath: character.characterID)
                            }
                            else
                            {
                                if let _ = completion {
                                    
                                    completion!(character: character, mediaImage: nil)
                                    
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
