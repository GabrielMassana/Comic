//
//  CharacterRequest.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking

class CharacterRequest: Request {

    //MARK: - Init

    class func requestWithOffset(offset: Int)  -> Self {
        
        let characterRequest = self.requestForAPI()
        
        return characterRequest
    }
    
    //MARK: - UpdateRequest

    override func updateRequestWithEndpoint(endpoint: NSString) {
        
        let UUID: String = NSUUID().UUIDString
        let hashString: String = NSString(format: "%@%@%@", UUID, PrivateKey, PublicKey) as String
        let md5: String = hashString.md5()

        let url: String = String(format:"https://gateway.marvel.com%@?ts=%@&apikey=%@&hash=%@", endpoint, UUID, PublicKey, md5)
        
        HTTPMethod = CNMHTTPRequestMethodGet
        URL = NSURL(string: url)
    }
}
