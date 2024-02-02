//
//  String+md5.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import CommonCrypto
import UIKit

extension String {
    func encrypted(keepingPrefix prefixLength: Int, andSuffix suffixLength: Int) -> String {
        guard count > prefixLength + suffixLength, prefixLength >= 0, suffixLength >= 0 else {
            return self
        }

        let startIndex = startIndex
        let endIndex = index(endIndex, offsetBy: -suffixLength)
        let range = index(startIndex, offsetBy: prefixLength) ..< endIndex

        let encryptedString = replacingCharacters(
            in: range,
            with: String(repeating: "*", count: count - prefixLength - suffixLength)
        )

        return encryptedString
    }

    func md5() -> String {
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
