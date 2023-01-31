//
//  String+md5.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/6/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    
    public func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
            
        free(result)
        return String(format: hash as String)
    }
}
