//
//  String+MD5.swift
//  Comic
//
//  Created by Gabriel Massana on 19/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//
//  From: http://stackoverflow.com/a/31932898/1381708
//

import Foundation

extension String {
    
    //MARK: - Encrypt
    
    /**
    md5 diges the self string
    
    - returns: the md5 string 
    */
    func md5() -> String! {
        
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
}