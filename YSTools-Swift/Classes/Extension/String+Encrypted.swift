//
//  String+md5.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import CryptoKit
import Foundation

public extension String {
    func encrypted(keepingPrefix prefixLength: Int, andSuffix suffixLength: Int) -> String {
        guard !isEmpty else {
            return ""
        }

        guard prefixLength >= 0, suffixLength >= 0, count > prefixLength + suffixLength else {
            return String(repeating: "*", count: count)
        }

        let startIndex = startIndex
        guard let suffixStart = index(endIndex, offsetBy: -suffixLength, limitedBy: startIndex),
              let prefixEnd = index(startIndex, offsetBy: prefixLength, limitedBy: endIndex),
              prefixEnd < suffixStart else {
            return String(repeating: "*", count: count)
        }
        let range = prefixEnd ..< suffixStart

        let encryptedString = replacingCharacters(
            in: range,
            with: String(repeating: "*", count: count - prefixLength - suffixLength)
        )

        return encryptedString
    }

    func md5() -> String {
        let digest = Insecure.MD5.hash(data: Data(utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
