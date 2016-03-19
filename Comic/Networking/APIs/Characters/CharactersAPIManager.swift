//
//  CharactersAPIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking

class CharactersAPIManager: APIManager {

    //MARK: - RetrieveCharacters

    class func retrieveCharacters(success: NetworkingOnSuccess, failure: NetworkingOnFailure) {
        
        // Offset from Core Data
        let characterRequest: CharacterRequest = CharacterRequest.requestWithOffset(0)
        
        characterRequest.updateRequestWithEndpoint("/v1/public/characters")
        
        let task: CNMURLSessionDataTask = CNMSession.defaultSession().dataTaskFromRequest(characterRequest)
        
        task.onCompletion = { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            print(response)
            
            do {
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                print(json)
                
            }
            catch
            {
                
            }
        }
        
        
        task.resume()
        
        print(characterRequest)
    }
}
