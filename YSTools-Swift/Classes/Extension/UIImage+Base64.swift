//
//  UIImage+Extension.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIImage {
    static func imageOfBase64String(_ str: String?) -> UIImage? {
        guard let str,
              let data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)
        else {
            return nil
        }

        return UIImage(data: data)
    }
}
