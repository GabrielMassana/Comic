//
//  APIManager.swift
//  Comic
//
//  Created by Gabriel Massana on 18/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

typealias NetworkingOnFailure = (error: NSError?) -> Void
typealias NetworkingOnSuccess = (result: AnyObject?) -> Void

class APIManager: NSObject {

    //MARK: - Accessors

    var onFailure: NetworkingOnFailure?
    var onSuccess: NetworkingOnSuccess?    
}
