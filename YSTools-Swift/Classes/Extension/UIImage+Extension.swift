//
//  UIImage+Extension.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UIImage {
    
    public static func imageOfBase64String(_ str: String?) -> UIImage? {
        guard let str = str, let data = Data(base64Encoded: str, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        let img = UIImage(data: data)
        return img
    }
}

