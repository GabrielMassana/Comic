//
//  Request.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

import CoreNetworking

let PublicKey: String = "6c3ee59b795443c3ec99cd142c50e639"
let PrivateKey: String = "3c5ec772a2885a3637466e4784d149a0c772b611"

class Request: CNMRequest {

    //MARK: - Init
    
    class func requestForAPI() -> Self  {
        
        
        let request = self.init()
        
        
        return request
    }
    
    //MARK: - UpdateRequest
    
    func updateRequestWithEndpoint(endpoint: NSString) {
        
    }
}
