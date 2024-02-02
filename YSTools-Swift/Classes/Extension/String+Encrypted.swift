//
// *************************************************
// Created by Joseph Koh on 2023/11/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/11/22 00:58
// *************************************************
//

extension String {
    func encrypted(keepingPrefix prefixLength: Int, andSuffix suffixLength: Int) -> String {
        guard count > prefixLength + suffixLength, prefixLength >= 0, suffixLength >= 0 else {
            return self
        }

        let startIndex = startIndex
        let endIndex = index(endIndex, offsetBy: -suffixLength)
        let range = index(startIndex, offsetBy: prefixLength) ..< endIndex

        let encryptedString = replacingCharacters(in: range, with: String(repeating: "*", count: count - prefixLength - suffixLength))

        return encryptedString
    }
}
