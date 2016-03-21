//
//  CharactersAPIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking
import CoreOperation

class CharactersAPIManager: APIManager {

    //MARK: - RetrieveCharacters

    class func retrieveCharacters(offset: String, success: NetworkingOnSuccess, failure: NetworkingOnFailure) {
        
        // Offset from Core Data
        let characterRequest: CharacterRequest = CharacterRequest.requestWithOffset(0)
        
        characterRequest.updateRequestWithEndpoint("/v1/public/characters", offset: offset)
        
        let task: CNMURLSessionDataTask = CNMSession.defaultSession().dataTaskFromRequest(characterRequest)
        
        task.onCompletion = { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let _ = data {
                
                do {
                    let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    
                    let operation: CharactersParserOperation = CharactersParserOperation(charactersResponse: json)
                    operation.operationQueueIdentifier = LocalDataOperationQueueTypeIdentifier
                    
                    operation.onSuccess = { (result:AnyObject?) -> Void in
                        
                        success(result: nil)
                    }
                    
                    COMOperationQueueManager.sharedInstance().addOperation(operation)
                }
                catch
                {
                    print(error)
                    failure(error: nil)
                }
            }
            else
            {
                failure(error: error)
            }
        }
        
        task.resume()
        
        print(characterRequest)
    }
}
